//
//  BookmarkLayout.swift
//  Home
//
//  Created by 김동준 on 1/15/26
//

import UIKit

protocol BookmarkLayoutDelegate: AnyObject {
    func widthForItem(at indexPath: IndexPath) -> CGFloat
    func heightForBookmarkHeader() -> CGFloat
}

final class BookmarkLayout: UICollectionViewLayout {
    weak var delegate: BookmarkLayoutDelegate?
    
    private let itemSpacing: CGFloat = 10
    private let hPadding: CGFloat = 20
    private let itemHeight: CGFloat = 128
    
    private var calculatedCellAttributes: [UICollectionViewLayoutAttributes] = []
    private var calculatedHeaderAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat = 0
    private let sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override func prepare() {
        guard let collectionView = collectionView else { return }

        calculatedCellAttributes.removeAll()
        calculatedHeaderAttributes.removeAll()

        let sectionCount = collectionView.numberOfSections
        let headerHeight = delegate?.heightForBookmarkHeader() ?? 44
        
        var xOffsets: CGFloat = sectionInset.left
        let yOffests = headerHeight
        
        // Header
        let headerIndexPath = IndexPath(item: 0, section: 0)
        let headerAttributes = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            with: headerIndexPath
        )
        headerAttributes.frame = CGRect(
            x: sectionInset.left,
            y: 0,
            width: collectionView.bounds.width,
            height: headerHeight
        )
        calculatedHeaderAttributes.append(headerAttributes)
        
        guard sectionCount > 0 else { return }
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: 0)
            let itemWidth = delegate?.widthForItem(at: indexPath) ?? 120
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(
                x: xOffsets,
                y: yOffests,
                width: itemWidth,
                height: itemHeight
            )
            calculatedCellAttributes.append(attributes)
            
            xOffsets += itemWidth + itemSpacing
        }
        
        contentWidth = max(
            xOffsets - itemSpacing + sectionInset.right,
            collectionView.bounds.width + 1
        )
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttributes: [UICollectionViewLayoutAttributes] = []

        for attributes in calculatedHeaderAttributes where attributes.frame.intersects(rect) {
            visibleAttributes.append(attributes)
        }

        for attributes in calculatedCellAttributes where attributes.frame.intersects(rect) {
            visibleAttributes.append(attributes)
        }
        
        return visibleAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return calculatedCellAttributes.first { $0.indexPath == indexPath }
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return calculatedHeaderAttributes.first { $0.indexPath.section == indexPath.section }
        }
        return nil
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(
            width: contentWidth,
            height: (delegate?.heightForBookmarkHeader() ?? 44) + itemHeight
        )
    }
}
