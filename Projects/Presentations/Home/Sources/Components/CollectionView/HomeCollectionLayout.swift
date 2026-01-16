//
//  HomeCollectionLayout.swift
//  Home
//
//  Created by 김동준 on 1/16/26
//

import UIKit

protocol BookmarkDelegate: AnyObject {
    func widthForItem(at indexPath: IndexPath) -> CGFloat
}

protocol WaterfallDelegate: AnyObject {
    func heightForItem(at indexPath: IndexPath, width: CGFloat) -> CGFloat
}

final class HomeCollectionLayout: UICollectionViewLayout {
    weak var bookmarkDelegate: BookmarkDelegate?
    weak var waterfallDelegate: WaterfallDelegate?
    
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = .zero
    
    // 레이아웃 준비
    override func prepare() {
        guard let collectionView = collectionView else { return }

        attributes.removeAll()
        
        var yOffsets: CGFloat = 0
        
        for section in 0..<collectionView.numberOfSections {
            switch HomeCollectionSection(rawValue: section) {
            case .bookmark:
                yOffsets = layoutBookmarkSection(
                    section: section,
                    startY: yOffsets,
                    collectionView: collectionView
                )
            case .waterfall:
                yOffsets = layoutWaterfallSection(
                    section: section,
                    startY: yOffsets,
                    collectionView: collectionView
                )
            case .none:
                break
            }
        }
        
        contentSize = CGSize(
            width: collectionView.bounds.width,
            height: yOffsets
        )
    }
    
    // 화면에 보이는 셀들의 레이아웃 정보 반환
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes.filter { $0.frame.intersects(rect) } // 현재 화면 영역과 프레임이 겹치는 것만
    }
    
    // 특정 셀의 레이아웃 정보 반환
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes.first { $0.indexPath == indexPath }
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes.first {
            $0.representedElementKind == elementKind &&
            $0.indexPath.section == indexPath.section
        }
    }
    
    override var collectionViewContentSize: CGSize {
        contentSize
    }
}

private extension HomeCollectionLayout {
    func layoutBookmarkSection(
        section: Int,
        startY: CGFloat,
        collectionView: UICollectionView
    ) -> CGFloat {
        let headerHeight: CGFloat = 44
        let hPadding: CGFloat = 20
        
        let headerIndexPath = IndexPath(indexes: [section])
        let headerAttributes = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            with: headerIndexPath
        )
        headerAttributes.frame = CGRect(
            x: hPadding,
            y: startY,
            width: collectionView.bounds.width, // TODO: width 조절해보기 필요. 지금은 풀로 적용
            height: headerHeight
        )
        attributes.append(headerAttributes)
        
        let sectionCount = collectionView.numberOfSections
        guard sectionCount > 0 else { return 0 }
        
        var xOffsets: CGFloat = hPadding
        let yOffsets = startY + headerHeight
        let itemHeight: CGFloat = 128
        let itemSpacing: CGFloat = 10
        
        let itemCount = collectionView.numberOfItems(inSection: section)
        
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: section)
            let itemWidth = bookmarkDelegate?.widthForItem(at: indexPath) ?? 120
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(
                x: xOffsets,
                y: yOffsets,
                width: itemWidth,
                height: itemHeight
            )
            self.attributes.append(attributes)
            
            xOffsets += itemWidth + itemSpacing
        }
        
        return yOffsets + itemHeight
    }
}

private extension HomeCollectionLayout {
    func layoutWaterfallSection(
        section: Int,
        startY: CGFloat,
        collectionView: UICollectionView
    ) -> CGFloat {
        let headerHeight: CGFloat = 44
        let itemSpacing: CGFloat = 10
        let numberOfColumns: Int = 2
        let hPadding: CGFloat = 20
        let contentWidth: CGFloat = collectionView.bounds.width
        
        let headerIndexPath = IndexPath(indexes: [section])
        let headerAttributes = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            with: headerIndexPath
        )
        headerAttributes.frame = CGRect(
            x: hPadding,
            y: startY,
            width: collectionView.bounds.width,
            height: headerHeight
        )
        attributes.append(headerAttributes)
        
        // 컬럼 width 계산
        let totalSpacing = itemSpacing * CGFloat(numberOfColumns - 1)
        let availableWidth = contentWidth - (hPadding * 2) - totalSpacing
        let eachColumnWidth = availableWidth / CGFloat((numberOfColumns))
        
        // 각 컬럼의 x 좌표
        var xOffsets: [CGFloat] = []
        for column in 0..<numberOfColumns {
            let x = hPadding + (eachColumnWidth + itemSpacing) * CGFloat(column)
            xOffsets.append(x)
        }

        // 각 컬럼의 현재 y 좌표
        var yOffsets: [CGFloat] = Array(repeating: startY + headerHeight, count: numberOfColumns)
        
        // 모든 아이템 배치
        let itemCount = collectionView.numberOfItems(inSection: section)
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: section)
            
            // delegate로부터 높이 받기
            let height = waterfallDelegate?.heightForItem(at: indexPath, width: eachColumnWidth) ?? 180
            
            // 가장 짧은 컬럼 찾기 -> Waterfall 레이아웃은 다음 아이템을 현재 가장 높이가 낮은 컬럼에 놓기에 shortest 찾아서 넣을 것.
            let shortestColumn = yOffsets.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
            
            // 프레임 만들기 -> 를 가장 짧은 곳에 frame 만들어서 넣기
            let targetFrame = CGRect(
                x: xOffsets[shortestColumn],
                y: yOffsets[shortestColumn],
                width: eachColumnWidth,
                height: height
            )
            
            // 속성 저장
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = targetFrame
            self.attributes.append(attributes)
            
            // 해당 컬럼 높이 업데이트
            yOffsets[shortestColumn] = targetFrame.maxY + itemSpacing
        }
        
        // 가장 긴 컬럼을 전체 높이로 설정
        return yOffsets.max() ?? 0
    }
}
