//
//  TabBarConfiguration.swift
//  Root
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import DesignSystem

enum TabBarCase {
    case home
    case randomPhoto
}

struct TabBarConfiguration {
    static func getTabInfo(_ tabCase: TabBarCase) -> UITabBarItem {
        let image = switch tabCase {
        case .home:
            RImages.house.image
        case .randomPhoto:
            RImages.cards.image
        }
        
        let item = UITabBarItem(
            title: nil,
            image: image,
            selectedImage: image
        )
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return item
    }
}
