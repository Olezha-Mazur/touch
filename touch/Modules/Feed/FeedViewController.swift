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
    private var items: [FeedUIItem] = []
    
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
        setupBindings()
        viewModel.loadData()
    }
    
    private func setupBindings() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    @objc private func didPullToRefresh() {
        viewModel.refreshData()
    }
    
    // тут пока поставил заглушки состояния, но эти принты в 5ой лабе поменяются на изменения вьюхи
    private func render(_ state: FeedViewState) {
        switch state {
        case .idle:
            print("[FEED] Состояние: Ожидание")
            break
            
        case .loading:
            print("[FEED] Состояние: Загрузка первой страницы...")
            if items.isEmpty {
            }
            
        case .content(let loadedItems, _):
            self.items = loadedItems
            print("[FEED] Состояние: Контент загружен. Постов: \(items.count)")
            
        case .empty:
            print("[FEED] Состояние: Пусто (постов нет)")
            
        case .error(let message):
            print("[FEED] Состояние: Ошибка - \(message)")
        }
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let item = items[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.textProperties.font = .boldSystemFont(ofSize: 16)
        
        content.secondaryText = item.bodyPreview
        content.secondaryTextProperties.numberOfLines = 3
        
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectPost(id: items[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 2 {
            viewModel.loadNextPage()
        }
    }
}

