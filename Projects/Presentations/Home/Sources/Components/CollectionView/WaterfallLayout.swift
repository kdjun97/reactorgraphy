//
//  WaterfallLayout.swift
//  Home
//
//  Created by 김동준 on 1/13/26
//

import UIKit

protocol WaterfallLayoutDelegate: AnyObject {
    func heightForItem(at indexPath: IndexPath, width: CGFloat) -> CGFloat
    func heightForHeader() -> CGFloat
}

final class WaterfallLayout: UICollectionViewLayout {
    weak var delegate: WaterfallLayoutDelegate?
    
    private let numberOfColumns: Int = 2
    private let itemSpacing: CGFloat = 10
    private let hPadding: CGFloat = 20
    
    private var calculatedCellAttributes: [UICollectionViewLayoutAttributes] = []
    private var calculatedHeaderAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }
    
    // 스크롤 영역 크기
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    // 레이아웃 준비
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        calculatedCellAttributes.removeAll()
        calculatedHeaderAttributes.removeAll()
        contentHeight = 0
        
        guard collectionView.numberOfSections > 0 else { return }
        
        let headerHeight = delegate?.heightForHeader() ?? 0
        if headerHeight > 0 {
            let headerAttributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                with: IndexPath(item: 0, section: 0)
            )
            headerAttributes.frame = CGRect(
                x: 20,
                y: 0,
                width: contentWidth,
                height: headerHeight
            )
            calculatedHeaderAttributes.append(headerAttributes)
            contentHeight = headerHeight
        }
        
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
        var yOffsets: [CGFloat] = Array(repeating: contentHeight, count: numberOfColumns)
        
        // 모든 아이템 배치
        let itemCount = collectionView.numberOfItems(inSection: 0) // 이거 Section 두개 쓸 때, enum으로 바꾸면 될듯
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: 0)
            
            // delegate로부터 높이 받기
            let height = delegate?.heightForItem(at: indexPath, width: eachColumnWidth) ?? 180
            
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
            calculatedCellAttributes.append(attributes)
            
            // 해당 컬럼 높이 업데이트
            yOffsets[shortestColumn] = targetFrame.maxY + itemSpacing
        }
        
        // 가장 긴 컬럼을 전체 높이로 설정
        contentHeight = yOffsets.max() ?? 0
    }
    
    // 화면에 보이는 셀들의 레이아웃 정보 반환
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Header -> 현재 화면 영역과 헤더 프레임이 겹치면 추가
        for attributes in calculatedHeaderAttributes where attributes.frame.intersects(rect) {
            visibleAttributes.append(attributes)
        }
        
        // Cell -> 현재 화면 영역과 Cell 프레임이 겹치면 추가
        for attributes in calculatedCellAttributes where attributes.frame.intersects(rect) {
            visibleAttributes.append(attributes)
        }
        
        return visibleAttributes
    }
    
    // 특정 셀의 레이아웃 정보 반환
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return calculatedCellAttributes.first { $0.indexPath == indexPath }
    }
    
    override func layoutAttributesForSupplementaryView(
        ofKind elementKind: String,
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return calculatedHeaderAttributes.first { $0.indexPath.section == indexPath.section }
        }
        return nil
    }
}
