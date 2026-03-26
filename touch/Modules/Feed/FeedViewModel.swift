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
    
    private var currentItems: [FeedUIItem] = []
    private var currentPage: Int = 1
    private let limit: Int = 10
    private var isLastPageReached = false
    
    private var currentTask: Task<Void, Never>?
    
    init(service: FeedServiceProtocol, router: FeedRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func loadData() {
        fetchPosts(page: 1, isRefresh: false)
    }
    
    func refreshData() {
        fetchPosts(page: 1, isRefresh: true)
    }
    
    func loadNextPage() {
        guard !isLastPageReached, currentTask == .none else { return }
        let nextPage = currentPage + 1
        fetchPosts(page: nextPage, isRefresh: false)
    }
    
    func didSelectPost(id: String) {
        router.routeToPostDetails(postId: id)
    }
    
    private func fetchPosts(page: Int, isRefresh: Bool) {
        currentTask?.cancel()
        
        let isPaginating = page > 1
        
        if isRefresh {
            isLastPageReached = false
            currentItems = []
        }
        
        if currentItems.isEmpty {
            onStateChange?(.loading)
        } else if isPaginating {
            onStateChange?(.content(items: currentItems, isPaginating: true))
        }
        
        currentTask = Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let domainPosts = try await self.service.getPosts(page: page, limit: self.limit)
                
                if Task.isCancelled { return }
                
                if domainPosts.isEmpty {
                    self.isLastPageReached = true
                } else {
                    self.currentPage = page
                    let newUIItems = domainPosts.map { self.mapToUIItem($0) }
                    
                    if isRefresh {
                        self.currentItems = newUIItems
                    } else {
                        self.currentItems.append(contentsOf: newUIItems)
                    }
                }
                
                await MainActor.run {
                    if self.currentItems.isEmpty {
                        self.onStateChange?(.empty)
                    } else {
                        self.onStateChange?(.content(items: self.currentItems, isPaginating: false))
                    }
                }
                
            } catch {
                if Task.isCancelled { return }
                
                await MainActor.run {
                    let errorMessage = self.parseError(error)
                    if self.currentItems.isEmpty {
                        self.onStateChange?(.error(message: errorMessage))
                    } else {
                        self.onStateChange?(.content(items: self.currentItems, isPaginating: false))
                    }
                }
            }
            self.currentTask = .none
        }
    }
    
    private func mapToUIItem(_ post: Post) -> FeedUIItem {
        let cleanText = post.text.replacingOccurrences(of: "\n", with: " ")
        return FeedUIItem(
            id: post.id,
            title: post.author,
            bodyPreview: cleanText
        )
    }
    
    private func parseError(_ error: Error) -> String {
        switch error {
        case NetworkError.timeout:
            return "Превышено время ожидания ответа сервера."
            
        case NetworkError.decodingError:
            return "Ошибка обработки данных."
            
        case NetworkError.badStatusCode(let code):
            return "Внутренняя ошибка сервера (Код: \(code))"
            
        case NetworkError.cancelled:
            return "Операция была отменена."
            
        case NetworkError.invalidURL, NetworkError.unknown:
            return "Ошибка сети. Проверьте интернет-соединение."
            
        default:
            return "Неизвестная ошибка связи: \(error.localizedDescription)"
        }
    }

}
