//
//  AuthService.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

final class AuthService: AuthServiceProtocol {
    func login(request: LoginRequest) throws -> UserSession {
        guard !request.email.isEmpty, !request.pass.isEmpty else {
            throw AuthError.emptyFields
        }
        
        if request.email == "admin" && request.pass == "1234" {
            return UserSession(token: "abc123_mock_token", userId: "oleg")
        } else {
            throw AuthError.invalidCredentials
        }
    }
    
    func register(request: RegisterRequest) throws -> UserSession {
        return UserSession(token: "321cba...", userId: "another")
    }
}
