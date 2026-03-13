//
//  ProfileService.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//
import Foundation

final class ProfileService: ProfileServiceProtocol {
    func getProfile(userId: String) throws -> UserProfile {
        return UserProfile(
            id: userId,
            nickname: "oleg_mazur",
            avatarURL: URL(string: "https://myserver.com/avatars/\(userId).png")
        )
    }
}
