//
//  FeedRouter.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class FeedRouter: FeedRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToPostDetails(postId: String) {
    }
}
