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
    
    public override init() {
        self.navigationController = BaseNavigationController()
        super.init()
        print("⭕ RandomPhotoCoordinator init!")
    }
    
    deinit {
        print("❎ RandomPhotoCoordinator deinit!")
    }
    
    public override func start() {
        let keyChainUseCase: KeyChainUseCase = DIContainer.shared.resolve()
        let photoUseCase: PhotoUseCase = DIContainer.shared.resolve()
        let reactor = RandomPhotoReactor(
            keyChainUseCase: keyChainUseCase,
            photoUseCase: photoUseCase
        )
        let viewController = RandomPhotoViewController(reactor: reactor)
        navigationController.viewControllers = [viewController]
    }
}
