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
    private let listManager = FeedListManager()
    
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
        
        setupTableManager()
        setupActions()
        setupBindings()
        
        viewModel.loadData()
    }
    
    private func setupTableManager() {
        customView.tableView.dataSource = listManager
        customView.tableView.delegate = listManager
        listManager.delegate = self
    }
    
    private func setupActions() {
        customView.refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        customView.retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    @objc private func didPullToRefresh() {
        viewModel.refreshData()
    }
    
    @objc private func didTapRetry() {
        viewModel.loadData()
    }
    
    private func hideAllUI() {
        customView.tableView.isHidden = true
        customView.activityIndicator.stopAnimating()
        customView.messageLabel.isHidden = true
        customView.retryButton.isHidden = true
    }
    
    private func render(_ state: FeedViewState) {
        hideAllUI()
        
        switch state {
        case .idle:
            print("[FEED] Состояние: Ожидание")
            break
            
        case .loading:
            customView.activityIndicator.startAnimating()
            
        case .content(let loadedItems, let isPaginating):
            customView.tableView.isHidden = false
            customView.refreshControl.endRefreshing()
            
            listManager.update(items: loadedItems)
            customView.tableView.reloadData()
            
            if isPaginating {
                customView.tableView.tableFooterView = customView.createPaginationFooter()
            } else {
                customView.tableView.tableFooterView = nil
            }
            
        case .empty:
            customView.messageLabel.text = "Здесь пока нет постов"
            customView.messageLabel.isHidden = false
            customView.refreshControl.endRefreshing()
            
        case .error(let message):
            customView.messageLabel.text = message
            customView.messageLabel.isHidden = false
            customView.retryButton.isHidden = false
            customView.refreshControl.endRefreshing()
        }
    }
}



extension FeedViewController: FeedListManagerDelegate {
    func didSelectPost(id: String) {
        viewModel.didSelectPost(id: id)
    }
    
    func scrolledNearBottom() {
        viewModel.loadNextPage()
    }
}

