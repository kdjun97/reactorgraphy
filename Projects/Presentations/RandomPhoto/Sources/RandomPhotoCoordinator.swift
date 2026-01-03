//
//  RandomPhotoCoordinator.swift
//  RandomPhoto
//
//  Created by 김동준 on 1/2/26
//

import Base
import UIKit

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
        let randomPhotoViewController = RandomPhotoViewController()
        navigationController.viewControllers = [randomPhotoViewController]
    }
}
