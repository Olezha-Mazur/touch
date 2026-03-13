//
//  ProfileViewController.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    private lazy var customView = ProfileView()
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    private func render(_ state: ProfileViewState) {
    }
}
