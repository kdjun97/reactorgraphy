//
//  BaseNavigationController.swift
//  Base
//
//  Created by 김동준 on 12/29/25
//

import UIKit

public final class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    public override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
