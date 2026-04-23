//
//  BDUIViewController.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

enum BDUIViewState {
    case loading
    case content(node: BDUINode)
    case error(message: String)
}

final class BDUIViewController: UIViewController {
    
    private var viewModel: BDUIViewModelProtocol
    
    private lazy var actionHandler: BDUIActionHandler = {
        let handler = BDUIActionHandler(viewController: self)
        handler.onReload = { [weak self] in
            self?.viewModel.loadData()
        }
        return handler
    }()

    private lazy var mapper = BDUIMapper(actionHandler: actionHandler)
    
    private lazy var bduiContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = DS.Colors.primary
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(viewModel: BDUIViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DS.Colors.background
        
        setupLayout()
        setupBindings()
        
        viewModel.loadData()
    }
    
    private func setupLayout() {
        view.addSubview(bduiContainer)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            bduiContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bduiContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bduiContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bduiContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: BDUIViewState) {
        bduiContainer.subviews.forEach { $0.removeFromSuperview() }
        activityIndicator.stopAnimating()
        
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            
        case .content(let node):
            let bduiView = mapper.map(node: node)
            bduiView.translatesAutoresizingMaskIntoConstraints = false
            bduiContainer.addSubview(bduiView)
            
            NSLayoutConstraint.activate([
                bduiView.topAnchor.constraint(equalTo: bduiContainer.topAnchor),
                bduiView.bottomAnchor.constraint(equalTo: bduiContainer.bottomAnchor),
                bduiView.leadingAnchor.constraint(equalTo: bduiContainer.leadingAnchor),
                bduiView.trailingAnchor.constraint(equalTo: bduiContainer.trailingAnchor)
            ])
            
        case .error(let message):
            print("Ошибка BDUI: \(message)")
        }
    }
}
