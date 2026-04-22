//
//  Services.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

protocol AuthServiceProtocol {
    func login(request: LoginRequest) throws -> UserSession
    func register(request: RegisterRequest) throws -> UserSession
}

protocol FeedServiceProtocol {
    func getPosts(page: Int, limit: Int) async throws -> [Post]
}

protocol ProfileServiceProtocol {
    func getProfile(userId: String) throws -> UserProfile
}
