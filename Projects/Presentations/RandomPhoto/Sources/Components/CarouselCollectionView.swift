//
//  CarouselCollectionView.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/6/26
//

import SnapKit
import DesignSystem
import UIKit

final class CarouselCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: Self.makeFlowLayout())
        setupUI()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CarouselCollectionView {
    func setupUI() {
        self.backgroundColor = .systemBackground
        self.showsHorizontalScrollIndicator = false
    }
    
    func registerCell() {
        self.register(
            RandomPhotoCell.self,
            forCellWithReuseIdentifier: RandomPhotoCell.reuseID
        )
    }
}

private extension CarouselCollectionView {
    static func makeFlowLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(327 / 375),
            heightDimension: .estimated(445+120)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 8
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
