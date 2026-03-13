//
//  AuthService.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

final class AuthService: AuthServiceProtocol {
    func login(request: LoginRequest) throws -> UserSession {
        return UserSession(token: "abc123...", userId: "oleg")
    }
    
    func register(request: RegisterRequest) throws -> UserSession {
        return UserSession(token: "321cba...", userId: "another")
    }
}
