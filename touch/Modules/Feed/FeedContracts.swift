//
//  FeedContracts.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

struct FeedUIItem: Equatable {
    let id: String
    let title: String
    let bodyPreview: String
}

enum FeedViewState: Equatable {
    case idle
    case loading
    case content(items: [FeedUIItem], isPaginating: Bool)
    case empty
    case error(message: String)
}

protocol FeedViewModelProtocol {
    var onStateChange: ((FeedViewState) -> Void)? { get set }
    
    func loadData()
    func refreshData()
    func loadNextPage()
    func didSelectPost(id: String)
}

protocol FeedRouterProtocol {
    func routeToPostDetails(postId: String)
}
