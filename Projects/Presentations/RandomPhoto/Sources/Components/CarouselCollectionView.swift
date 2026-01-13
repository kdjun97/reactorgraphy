//
//  CarouselCollectionView.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/6/26
//

import SnapKit
import DesignSystem
import UIKit
import RxRelay

final class CarouselCollectionView: UICollectionView {
    let currentIndexRelay = PublishRelay<Int>()
    private var lastIndex: Int = -1
    
    init() {
        let layout = UICollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setCollectionViewLayout(makeLayout(), animated: false)
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
        self.isScrollEnabled = false
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
    }
    
    func registerCell() {
        self.register(
            RandomPhotoCell.self,
            forCellWithReuseIdentifier: RandomPhotoCell.reuseID
        )
    }
}

private extension CarouselCollectionView {
    func makeLayout() -> UICollectionViewLayout {
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
        
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, environment in
            guard let self = self else { return }
            
            // 1. 현재 섹션 컨테이너의 중앙 지점 계산
            let centerX = point.x + (environment.container.contentSize.width / 2.0)
            
            // 2. 현재 보이는 아이템들 중 중앙 좌표와 가장 가까운 아이템(Cell) 찾기
            let centerItem = visibleItems
                .filter { $0.representedElementCategory == .cell }
                .min(by: { abs($0.frame.midX - centerX) < abs($1.frame.midX - centerX) })
            
            if let index = centerItem?.indexPath.item {
                if self.lastIndex != index {
                    self.lastIndex = index
                    self.currentIndexRelay.accept(index)
                }
            }
        }
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
