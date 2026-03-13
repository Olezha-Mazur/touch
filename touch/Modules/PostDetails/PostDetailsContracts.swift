//
//  PostDetailsContracts.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

struct PostDetailsUIItem {
    let fullText: String
    let author: String
    let dateString: String
    let isLikedByMe: Bool
}

enum PostDetailsViewState {
    case loading
    case content(PostDetailsUIItem)
    case error(String)
}

protocol PostDetailsViewModelProtocol {
    func viewDidLoad()
    func didTapLike()
    var onStateChange: ((PostDetailsViewState) -> Void)? { get set }
}

protocol PostDetailsRouterProtocol {
    func routeBack()
}
