//
//  FeedContracts.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

struct FeedUIItem: Equatable {
    let id: String
    let authorName: String
    let textPreview: String
}

enum FeedViewState: Equatable {
    case loading
    case content(items: [FeedUIItem])
    case empty
    case error(message: String)
}

protocol FeedViewModelProtocol {
    func viewDidLoad()
    func didSelectPost(id: String)
    var onStateChange: ((FeedViewState) -> Void)? { get set }
}

protocol FeedRouterProtocol {
    func routeToPostDetails(postId: String)
}
