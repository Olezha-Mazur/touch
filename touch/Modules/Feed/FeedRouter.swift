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
        let bduiService = BDUIService()
        let bduiVM = BDUIViewModel(service: bduiService)
        let bduiVC = BDUIViewController(viewModel: bduiVM)
        bduiVC.title = "Пост \(postId)"
        navigationController?.pushViewController(bduiVC, animated: true)
    }
}
