//
//  BookmarkDelegate+.swift
//  Home
//
//  Created by 김동준 on 1/16/26
//

import UIKit

extension HomeViewController: BookmarkDelegate {
    func widthForItem(at indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return 120
        }
        
        switch item {
        case .bookmark(let card):
            return card.width
        default:
            return 0
        }
    }
}
