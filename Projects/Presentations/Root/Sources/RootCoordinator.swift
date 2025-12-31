//
//  RootCoordinator.swift
//  Root
//
//  Created by 김동준 on 12/29/25
//

import Base
import Home

public final class RootCoordinator: BaseCoordinator {
    public let navigationController: BaseNavigationController
    
    public override init() {
        self.navigationController = BaseNavigationController()
        super.init()
        print("⭕ RootCoordinator init!")
    }
    
    deinit {
        print("❎ RootCoordinator deinit!")
    }
    
    public override func start() {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        addChild(coordinator)
        coordinator.start()
    }
}
