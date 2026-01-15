//
//  WaterfallLayoutDelegate+.swift
//  Home
//
//  Created by 김동준 on 1/15/26
//

import UIKit

extension HomeViewController: WaterfallLayoutDelegate {
    func heightForItem(at indexPath: IndexPath, width: CGFloat) -> CGFloat {
        guard let item = waterfallDataSource?.itemIdentifier(for: indexPath) else {
            return 180
        }
        
        switch item {
        case .waterfall(let photo):
            return photo.model.calculatedHeight(forWidth: width)
        }
    }
    
    func heightForHeader() -> CGFloat {
        return 44
    }
}
