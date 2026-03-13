//
//  AuthViewController.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class AuthViewController: UIViewController {
    private lazy var customView =  AuthView()
    private var viewModel: AuthViewModelProtocol
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        title = "Авторизация"
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func render(_ state: AuthViewState) {
    }
}

