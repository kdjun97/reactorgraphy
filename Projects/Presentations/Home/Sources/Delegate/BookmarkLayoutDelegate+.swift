//
//  BookmarkLayoutDelegate+.swift
//  Home
//
//  Created by 김동준 on 1/15/26
//

import UIKit

extension HomeViewController: BookmarkLayoutDelegate {
    func widthForItem(at indexPath: IndexPath) -> CGFloat {
        guard let item = bookmarkDataSource?.itemIdentifier(for: indexPath) else {
            return 120
        }
        
        switch item {
        case .bookmark(let card):
            return card.width
        }
    }
    
    func heightForBookmarkHeader() -> CGFloat {
        return 44
    }
}
