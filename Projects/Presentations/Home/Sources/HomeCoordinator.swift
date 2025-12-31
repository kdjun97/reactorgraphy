//
//  HomeCoordinator.swift
//  Home
//
//  Created by 김동준 on 12/29/25
//

import Base
import UIKit

public final class HomeCoordinator: BaseCoordinator {
    private let navigationController: BaseNavigationController
    
    public init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
        print("⭕ HomeCoordinator init!")
    }
    
    deinit {
        print("❎ HomeCoordinator deinit!")
    }
    
    public override func start() {
        let homeViewController = HomeViewController()
        navigationController.viewControllers = [homeViewController]
    }
}
