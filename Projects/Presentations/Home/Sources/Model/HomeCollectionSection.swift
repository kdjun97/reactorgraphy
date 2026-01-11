//
//  HomeCollectionSection.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import Domain

enum HomeCollectionSection: Int {
    case bookmark = 0
    case latestImage = 1
}

enum HomeCollectionItem: Hashable {
    case bookmark(BookmarkCardItem)
    case latestImage(LatestImageItem)
}
