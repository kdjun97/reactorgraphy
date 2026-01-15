//
//  HomeCollectionSection.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import Domain

enum BookmarkSection: Int {
    case bookmark = 0
}

enum BookmarkCollectionItem: Hashable {
    case bookmark(BookmarkCardItem)
}

enum WaterfallSection: Int {
    case waterfall = 0
}

enum WaterfallCollectionItem: Hashable {
    case waterfall(LatestImageItem)
}
