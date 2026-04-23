//
//  BDUIService.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import Foundation

protocol BDUIServiceProtocol {
    func fetchScreen() async throws -> BDUINode
}

final class BDUIService: BDUIServiceProtocol {
    func fetchScreen() async throws -> BDUINode {
        guard let url = Bundle.main.url(forResource: "PostDetailsBDUI", withExtension: "json") else {
            throw AppError.networkError
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(BDUINode.self, from: data)
    }
}
