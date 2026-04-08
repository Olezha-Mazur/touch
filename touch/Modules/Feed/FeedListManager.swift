//
//  FeedListManager.swift
//  touch
//
//  Created by Oleg Mazur on 07.04.2026.
//

import UIKit

protocol FeedListManagerDelegate: AnyObject {
    func didSelectPost(id: String)
    func scrolledNearBottom()
}

final class FeedListManager: NSObject {
    weak var delegate: FeedListManagerDelegate?
    private var items: [FeedUIItem] = []
    
    func update(items: [FeedUIItem]) {
        self.items = items
    }
}

extension FeedListManager: UITableViewDataSource, UITableViewDelegate {
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
        delegate?.didSelectPost(id: items[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 2 {
            delegate?.scrolledNearBottom()
        }
    }
}

