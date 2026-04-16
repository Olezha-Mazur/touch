//
//  AuthView.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class AuthView: UIView {
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.keyboardDismissMode = .interactive
        return scroll
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(.title1)
        label.text = "Вход"
        label.textAlignment = .center
        return label
    }()
    
    let emailField = DSTextField(placeholderText: "Логин (admin)")
    let passwordField = DSTextField(placeholderText: "Пароль (1234)", isSecure: true)
    let loginButton = DSButton(style: .primary)
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.apply(.error)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHiddenWhenEmpty = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DS.Colors.background
        
        emailField.keyboardType = .emailAddress
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .done
        
        setupLayout()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, emailField, passwordField, errorLabel, loginButton])
        stackView.axis = .vertical
        stackView.spacing = DS.Spacing.m
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: frameGuide.heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -DS.Spacing.xl),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.Spacing.xl),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DS.Spacing.xl),
            
            emailField.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight),
            passwordField.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight),
            loginButton.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight)
        ])
    }
}


