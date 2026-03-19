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
    
    func login(emailO: String?, passO: String?) {
        let email = emailO ?? ""
        let pass = passO ?? ""
        onStateChange?(.loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            do {
                let request = LoginRequest(email: email, pass: pass)
                let _ = try self.service.login(request: request)
                DispatchQueue.main.async {
                    self.router.routeToMainTab()
                }
            } catch {
                DispatchQueue.main.async {
                    self.onStateChange?(.error("Неверный логин или пароль.\nПопробуйте admin / 1234"))
                }
            }
        }
    }
    
    func register(emailO: String?, passO: String?) {
    }
}

