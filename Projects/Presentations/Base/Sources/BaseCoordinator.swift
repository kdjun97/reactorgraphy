//
//  BaseCoordinator.swift
//  Base
//
//  Created by 김동준 on 12/29/25
//

public protocol Coordinator: AnyObject {
    func start()
}

open class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    open func start() {}
    public init() {}
}

public extension BaseCoordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
