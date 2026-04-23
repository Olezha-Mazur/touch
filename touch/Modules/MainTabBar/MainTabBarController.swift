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

        view.backgroundColor = DS.Colors.background
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = DS.Colors.surface
        appearance.stackedLayoutAppearance.selected.iconColor = DS.Colors.primary
        appearance.stackedLayoutAppearance.normal.iconColor = DS.Colors.textSecondary
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = DS.Colors.primary

        let networkClient = URLSessionNetworkClient()
        let feedRouter = FeedRouter(navigationController: nil)
        let feedService = FeedService(networkClient: networkClient)
        let feedVM = FeedViewModel(service: feedService, router: feedRouter)
        let feedVC = FeedViewController(viewModel: feedVM)
        
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedRouter.navigationController = feedNav
        
        feedNav.tabBarItem = UITabBarItem(title: "Лента", image: DS.Icons.feed, tag: 0)
        let profileRouter = ProfileRouter(window: appWindow)
        let profileVM = ProfileViewModel(service: ProfileService(), router: profileRouter, userId: "oleg")
        let profileVC = ProfileViewController(viewModel: profileVM)
        
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Профиль", image: DS.Icons.profile, tag: 1)

        self.viewControllers = [feedNav, profileNav]
    }
}

