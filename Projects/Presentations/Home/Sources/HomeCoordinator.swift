//
//  HomeCoordinator.swift
//  Home
//
//  Created by 김동준 on 12/29/25
//

import Base
import UIKit
import DI

public final class HomeCoordinator: BaseCoordinator {
    public let navigationController: BaseNavigationController
    public let reactor: HomeReactor
    
    public override init() {
        self.navigationController = BaseNavigationController()
        self.reactor = HomeReactor(photoUseCase: DIContainer.shared.resolve())
        super.init()
        print("⭕ HomeCoordinator init!")
    }
    
    deinit {
        print("❎ HomeCoordinator deinit!")
    }
    
    public override func start() {
        let homeViewController = HomeViewController(reactor: reactor)
        navigationController.viewControllers = [homeViewController]
    }
}
