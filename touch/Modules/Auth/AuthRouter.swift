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
    }
}
