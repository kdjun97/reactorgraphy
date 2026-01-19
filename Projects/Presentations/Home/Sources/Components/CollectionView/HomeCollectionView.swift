//
//  HomeCollectionView.swift
//  Home
//
//  Created by 김동준 on 1/16/26
//

import UIKit

final class HomeCollectionView: UICollectionView {
    let homeCollectionViewLayout = HomeCollectionLayout()
    
    init () {
        super.init(frame: .zero, collectionViewLayout: homeCollectionViewLayout)
        setupUI()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeCollectionView {
    func setupUI() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func registerCell() {
        register(
            HomeBookmarkRowCell.self,
            forCellWithReuseIdentifier: HomeBookmarkRowCell.reuseID
        )
        register(
            LatestImageCell.self,
            forCellWithReuseIdentifier: LatestImageCell.reuseID
        )
        register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionHeaderView.reuseID
        )
    }
}
