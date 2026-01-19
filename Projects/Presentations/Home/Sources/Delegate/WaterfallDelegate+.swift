//
//  WaterfallDelegate+.swift
//  Home
//
//  Created by 김동준 on 1/16/26
//

import UIKit

extension HomeViewController: WaterfallDelegate {
    func heightForItem(at indexPath: IndexPath, width: CGFloat) -> CGFloat {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return 180
        }
        
        switch item {
        case .waterfall(let photo):
            return photo.model.calculatedHeight(forWidth: width)
        default:
            return 0
        }
    }
}
