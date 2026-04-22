//
//  DSButton.swift
//  touch
//
//  Created by Oleg Mazur on 14.04.2026.
//

import UIKit

final class DSButton: UIButton {
    struct Configuration {
        let title: String
        let style: Style
        var isLoading: Bool = false
        var isEnabled: Bool = true
    }
    
    enum Style { case primary, secondary }
    
    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setupHierarchy() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = DS.Spacing.cornerRadius
        titleLabel?.font = DSTextStyle.body.font
        
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with config: Configuration) {
        self.isEnabled = config.isEnabled && !config.isLoading
        switch config.style {
        case .primary:
            backgroundColor = config.isEnabled ? DS.Colors.primary : DS.Colors.primary.withAlphaComponent(0.5)
            setTitleColor(.white, for: .normal)
            spinner.color = .white
        case .secondary:
            backgroundColor = .clear
            setTitleColor(config.isEnabled ? DS.Colors.primary : DS.Colors.textSecondary, for: .normal)
            spinner.color = DS.Colors.primary
        }
        
        if config.isLoading {
            setTitle("", for: .normal)
            spinner.startAnimating()
            alpha = 0.7
        } else {
            setTitle(config.title, for: .normal)
            spinner.stopAnimating()
            alpha = config.isEnabled ? 1.0 : 0.5
        }
    }
}
