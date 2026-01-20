//
//  HomeBookmarkRowCell.swift
//  Home
//
//  Created by 김동준 on 1/17/26
//

import UIKit
import Domain

final class HomeBookmarkRowCell: UICollectionViewCell {
    static let reuseID = "HomeBookmarkRowCell"
    private var items: [BookmarkCardItem] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.estimatedItemSize = .zero

        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.backgroundColor = .clear
        colletionView.dataSource = self
        colletionView.delegate = self
        return colletionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        registerCell()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(items: [BookmarkCardItem]) {
        self.items = items
        collectionView.reloadData()
    }
}

private extension HomeBookmarkRowCell {
    func setupUI() {
        collectionView.frame = contentView.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupLayout() {
        contentView.addSubview(collectionView)
    }
    
    func registerCell() {
        collectionView.register(
            HomeBookmarkCell.self,
            forCellWithReuseIdentifier: HomeBookmarkCell.reuseID
        )
    }
}

extension HomeBookmarkRowCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeBookmarkCell.reuseID,
            for: indexPath
        ) as? HomeBookmarkCell else { return UICollectionViewCell() }

        let item = items[indexPath.item]
        cell.configure(width: item.width)
        return cell
    }
}

extension HomeBookmarkRowCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let item = items[indexPath.item]
        return CGSize(
            width: item.width,
            height: collectionView.bounds.height
        )
    }
}
