//
//  FeedViewModel.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

final class FeedViewModel: FeedViewModelProtocol {
    private let service: FeedServiceProtocol
    private let router: FeedRouterProtocol
    var onStateChange: ((FeedViewState) -> Void)?
    
    init(service: FeedServiceProtocol, router: FeedRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func viewDidLoad() {
    }
    
    func didSelectPost(id: String) {
        router.routeToPostDetails(postId: id)
    }
}
