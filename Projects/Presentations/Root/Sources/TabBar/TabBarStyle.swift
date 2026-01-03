//
//  TabBarStyle.swift
//  Root
//
//  Created by 김동준 on 1/2/26
//

import UIKit
import DesignSystem

struct TabBarStyle {
    let backgroundColor: UIColor
    let selectedColor: UIColor
    let unselectedColor: UIColor
    
    init(
        backgroundColor: UIColor = RColors.black90.color,
        selectedColor: UIColor = .white,
        unselectedColor: UIColor = .gray
    ) {
        self.backgroundColor = backgroundColor
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
    }
}
