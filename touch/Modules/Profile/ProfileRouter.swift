//
//  ProfileRouter.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class ProfileRouter: ProfileRouterProtocol {
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func routeToAuth() {
    }
}

