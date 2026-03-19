//
//  AuthRouter.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class AuthRouter: AuthRouterProtocol {
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func routeToMainTab() {
        let mainTabBar = MainTabBarController(window: self.window)
        
        window?.rootViewController = mainTabBar

        if let window = window {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}
