//
//  WaterfallCollectionView.swift
//  Home
//
//  Created by 김동준 on 1/13/26
//

import UIKit
import SnapKit

final class WaterfallCollectionView: UICollectionView {
    private let waterfallLayout = WaterfallLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: waterfallLayout)
        setupUI()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutDelegate(_ delegate: WaterfallLayoutDelegate?) {
        waterfallLayout.delegate = delegate
    }
}

private extension WaterfallCollectionView {
    func setupUI() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }

    func registerCell() {
        register(
            LatestImageCell.self,
            forCellWithReuseIdentifier: LatestImageCell.reuseID
        )
        register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionHeaderView.waterfallReuseID
        )
    }
}
