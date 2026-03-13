//
//  ProfileViewModel.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {
    private let service: ProfileServiceProtocol
    private let router: ProfileRouterProtocol
    private let currentUserId: String
    
    var onStateChange: ((ProfileViewState) -> Void)?
    
    init(service: ProfileServiceProtocol, router: ProfileRouterProtocol, userId: String) {
        self.service = service
        self.router = router
        self.currentUserId = userId
    }
    
    func viewDidLoad() {
    }
    
    func didTapLogout() {
        router.routeToAuth()
    }
}

