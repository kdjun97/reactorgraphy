//
//  RandomPhotoCoordinator.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/2/26
//

import Base
import UIKit
import ReactorKit
import Domain
import DI

public final class RandomPhotoCoordinator: BaseCoordinator {
    public let navigationController: BaseNavigationController
    public let reactor: RandomPhotoReactor
    
    public override init() {
        self.navigationController = BaseNavigationController()
        reactor = RandomPhotoReactor(
            keyChainUseCase: DIContainer.shared.resolve(),
            photoUseCase: DIContainer.shared.resolve()
        )

        super.init()
        print("⭕ RandomPhotoCoordinator init!")
    }
    
    deinit {
        print("❎ RandomPhotoCoordinator deinit!")
    }
    
    public override func start() {
        let viewController = RandomPhotoViewController(reactor: reactor)
        navigationController.viewControllers = [viewController]
    }
}
