//
//  ProfileContracts.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

struct ProfileUIItem: Equatable {
    let nickname: String
    let initials: String
}

enum ProfileViewState: Equatable {
    case loading
    case content(item: ProfileUIItem)
    case error(message: String)
}

protocol ProfileViewModelProtocol {
    func viewDidLoad()
    func didTapLogout()
    var onStateChange: ((ProfileViewState) -> Void)? { get set }
}

protocol ProfileRouterProtocol {
    func routeToAuth()
}
