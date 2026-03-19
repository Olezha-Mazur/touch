//
//  Models.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//
import Foundation

enum AuthError: Error {
    case invalidCredentials
    case emptyFields
}

struct LoginRequest {
    let email: String
    let pass: String
}

struct RegisterRequest {
    let email: String
    let pass: String
}

struct UserSession {
    let token: String
    let userId: String
}

struct Post {
    let id: String
    let text: String
    let author: String
}

struct UserProfile {
    let id: String
    let nickname: String
    let avatarURL: URL?
}

enum AppError: Error {
    case invalidData
    case networkError
}

