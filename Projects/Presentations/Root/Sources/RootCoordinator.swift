//
//  RootCoordinator.swift
//  Root
//
//  Created by 김동준 on 12/29/25
//

import Base
import Home
import UIKit
import RandomPhoto

public final class RootCoordinator: BaseCoordinator {
    public let tabBarController: UITabBarController
    
    public override init() {
        self.tabBarController = UITabBarController()
        super.init()
        print("⭕ RootCoordinator init!")
    }
    
    deinit {
        print("❎ RootCoordinator deinit!")
    }
    
    public override func start() {
        setupUI()
        setupTabBar()
    }
}

private extension RootCoordinator {
    func setupUI() {
        let style = TabBarStyle()
        tabBarController.tabBar.backgroundColor = style.backgroundColor
        tabBarController.tabBar.tintColor = style.selectedColor
        tabBarController.tabBar.unselectedItemTintColor = style.unselectedColor
    }
    
    func setupTabBar() {
        let homeCoordinator = HomeCoordinator()
        addChild(homeCoordinator)
        homeCoordinator.start()
        
        let randomPhotoCoordinator = RandomPhotoCoordinator()
        addChild(randomPhotoCoordinator)
        randomPhotoCoordinator.start()
        
        setupTabBarItem(
            homeCoordinator: homeCoordinator,
            randomPhotoCoordinator: randomPhotoCoordinator
        )
        tabBarController.setViewControllers(
            [homeCoordinator.navigationController, randomPhotoCoordinator.navigationController],
            animated: false
        )
    }
    
    func setupTabBarItem(
        homeCoordinator: HomeCoordinator,
        randomPhotoCoordinator: RandomPhotoCoordinator
    ) {
        let homeItem = TabBarConfiguration.getTabInfo(.home)
        let randomPhotoItem = TabBarConfiguration.getTabInfo(.randomPhoto)

        homeCoordinator.navigationController.tabBarItem = homeItem
        randomPhotoCoordinator.navigationController.tabBarItem = randomPhotoItem
    }
}
