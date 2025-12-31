//
//  AppCoordinator.swift
//  ReactorGraphy
//
//  Created by 김동준 on 12/29/25
//

import UIKit
import Root
import Base

final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    private var rootCoordinator: RootCoordinator?

    init(window: UIWindow) {
        self.window = window
        super.init()
        print("⭕ AppCoordinator init!")
    }
    
    override func start() {
        showRoot()
    }
}

private extension AppCoordinator {
    func showRoot() {
        let coordinator = RootCoordinator()
        self.rootCoordinator = coordinator
        addChild(coordinator)
        
        window.rootViewController = coordinator.navigationController
        coordinator.start()
    }
}
