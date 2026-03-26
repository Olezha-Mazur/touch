//
//  MainTabBarController.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {
    private weak var appWindow: UIWindow?
    
    init(window: UIWindow?) {
        self.appWindow = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .systemGray6
        
        let networkClient = URLSessionNetworkClient()
        let feedRouter = FeedRouter(navigationController: nil)
        let feedService = FeedService(networkClient: networkClient)
        let feedVM = FeedViewModel(service: feedService, router: feedRouter)
        let feedVC = FeedViewController(viewModel: feedVM)
        
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedRouter.navigationController = feedNav
        
        let profileRouter = ProfileRouter(window: appWindow)
        let profileVM = ProfileViewModel(service: ProfileService(), router: profileRouter, userId: "oleg")
        let profileVC = ProfileViewController(viewModel: profileVM)
        
        let profileNav = UINavigationController(rootViewController: profileVC)

        self.viewControllers = [feedNav, profileNav]
    }
}

