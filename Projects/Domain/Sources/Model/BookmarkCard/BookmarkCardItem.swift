//
//  BookmarkCardItem.swift
//  Domain
//
//  Created by 김동준 on 1/11/26
//

import Foundation

public struct BookmarkCardItem: Hashable {
    public let uuid = UUID()
    public let width: CGFloat
    
    public init(
        width: CGFloat = CGFloat.random(in: 50...250)
    ) {
        self.width = width
    }
}
