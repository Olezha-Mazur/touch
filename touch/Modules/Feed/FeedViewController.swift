//
//  FeedViewController.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class FeedViewController: UIViewController {
    private lazy var customView = FeedView()
    private var viewModel: FeedViewModelProtocol
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        viewModel.viewDidLoad()
    }
    
    private func render(_ state: FeedViewState) {
    }
}
