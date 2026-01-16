//
//  HomeSnapshotState.swift
//  Home
//
//  Created by 김동준 on 1/16/26
//

import Domain

struct HomeSnapshotState: Equatable {
    let bookmarks: [BookmarkCardItem]
    let waterfalls: [LatestImageItem]
    
    init(
        bookmarks: [BookmarkCardItem],
        waterfalls: [LatestImageItem]
    ) {
        self.bookmarks = bookmarks
        self.waterfalls = waterfalls
    }
}
