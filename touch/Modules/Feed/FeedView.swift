//
//  FeedView.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class FeedView: UIView {
    
    let refreshControl = UIRefreshControl()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = DS.Colors.background
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        return table
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = DS.Colors.primary
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let stateView = DSErrorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DS.Colors.background
        tableView.refreshControl = refreshControl
        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        addSubview(tableView)
        addSubview(activityIndicator)
        addSubview(stateView)
        
        stateView.isHiddenWhenEmpty = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stateView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stateView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stateView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func createPaginationFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: DS.Spacing.controlHeight))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = DS.Colors.primary
        spinner.center = footerView.center
        spinner.startAnimating()
        footerView.addSubview(spinner)
        return footerView
    }
}

extension UIView {
    var isHiddenWhenEmpty: Bool {
        get { return isHidden }
        set { isHidden = newValue }
    }
}


