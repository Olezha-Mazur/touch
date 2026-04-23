//
//  BDUIViewModel.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import Foundation

protocol BDUIViewModelProtocol {
    var onStateChange: ((BDUIViewState) -> Void)? { get set }
    func loadData()
}

final class BDUIViewModel: BDUIViewModelProtocol {
    private let service: BDUIServiceProtocol
    var onStateChange: ((BDUIViewState) -> Void)?
    
    init(service: BDUIServiceProtocol) {
        self.service = service
    }
    
    func loadData() {
        onStateChange?(.loading)
        
        Task {
            do {
                let node = try await service.fetchScreen()
                DispatchQueue.main.async { [weak self] in
                    self?.onStateChange?(.content(node: node))
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.onStateChange?(.error(message: "Не удалось загрузить BDUI экран"))
                }
            }
        }
    }
}

