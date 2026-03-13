//
//  AuthViewModel.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

final class AuthViewModel: AuthViewModelProtocol {
    private let service: AuthServiceProtocol
    private let router: AuthRouterProtocol
    var onStateChange: ((AuthViewState) -> Void)?
    
    init(service: AuthServiceProtocol, router: AuthRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func login(email: String, pass: String) {
    }
    
    func register(email: String, pass: String) {
    }
}

