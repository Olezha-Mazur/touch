//
//  DSErrorView.swift
//  touch
//
//  Created by Oleg Mazur on 14.04.2026.
//

import UIKit

final class DSErrorView: UIView {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView(image: DS.Icons.error)
        iv.tintColor = DS.Colors.error
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.apply(.body)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let retryButton = DSButton(style: .primary)
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(message: String, buttonTitle: String = "Повторить") {
        messageLabel.text = message
        retryButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [iconImageView, messageLabel, retryButton])
        stack.axis = .vertical
        stack.spacing = DS.Spacing.m
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DS.Spacing.l),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DS.Spacing.l),
            
            iconImageView.heightAnchor.constraint(equalToConstant: DS.Icons.Size.large),
            iconImageView.widthAnchor.constraint(equalToConstant: DS.Icons.Size.large),
            
            retryButton.heightAnchor.constraint(equalToConstant: 48),
            retryButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
