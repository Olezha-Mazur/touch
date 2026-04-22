//
//  FeedService.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

final class FeedService: FeedServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getPosts(page: Int, limit: Int) async throws -> [Post] {
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let dtos: [PostDTO] = try await networkClient.get(url: url)
        
        return dtos.map { dto in
            Post(
                id: String(dto.id),
                text: dto.body,
                author: "User #\(dto.userId)"
            )
        }
    }
}
