//
//  AuthContracts.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import Foundation

enum AuthViewState {
    case initial
    case loading
    case error(String)
}

protocol AuthViewModelProtocol {
    func login(emailO: String?, passO: String?)
    func register(emailO: String?, passO: String?)
    var onStateChange: ((AuthViewState) -> Void)? { get set }
}

protocol AuthRouterProtocol {
    func routeToMainTab()
}
