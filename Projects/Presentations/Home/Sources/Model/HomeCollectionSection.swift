//
//  HomeCollectionSection.swift
//  Home
//
//  Created by 김동준 on 1/11/26
//

import Domain

enum HomeCollectionSection: Int {
    case bookmark = 0
    case waterfall = 1
}

public enum HomeCollectionItem: Hashable {
    case bookmarkRow([BookmarkCardItem])
    case waterfall(WaterfallItem)
}
