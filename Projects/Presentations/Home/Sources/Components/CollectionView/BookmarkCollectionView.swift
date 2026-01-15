//
//  BookmarkCollectionView.swift
//  Home
//
//  Created by 김동준 on 1/10/26
//

import UIKit
import SnapKit

final class BookmarkCollectionView: UICollectionView {
    private let bookmarkLayout = BookmarkLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: bookmarkLayout)
        setupUI()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutDeleagte(_ delegate: BookmarkLayoutDelegate?) {
        bookmarkLayout.delegate = delegate
    }
}

private extension BookmarkCollectionView {
    func setupUI() {
        backgroundColor = .systemBackground
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func registerCell() {
        register(
            HomeBookmarkCell.self,
            forCellWithReuseIdentifier: HomeBookmarkCell.reuseID
        )
        register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeSectionHeaderView.reuseID
        )
    }
}
