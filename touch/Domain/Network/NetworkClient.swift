//
//  NetworkClient.swift
//  touch
//
//  Created by Oleg Mazur on 26.03.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case timeout
    case badStatusCode(Int)
    case decodingError
    case cancelled
    case unknown
}

protocol NetworkClient {
    func get<T: Decodable>(url: URL) async throws -> T
}

final class URLSessionNetworkClient: NetworkClient {
    private let urlSession: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15.0
        self.urlSession = URLSession(configuration: config)
    }
    
    func get<T: Decodable>(url: URL) async throws -> T {
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badStatusCode(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch let error as URLError where error.code == .cancelled {
            throw NetworkError.cancelled
        } catch let error as URLError where error.code == .timedOut {
            throw NetworkError.timeout
        } catch {
            throw error
        }
    }
}
