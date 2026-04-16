//
//  DSButton.swift
//  touch
//
//  Created by Oleg Mazur on 14.04.2026.
//

import UIKit

final class DSButton: UIButton {
    enum Style { case primary, secondary }
    private let style: Style
    
    private let spinner = UIActivityIndicatorView(style: .medium)
    private var originalTitle: String?

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = DS.Spacing.cornerRadius
        titleLabel?.font = DSTextStyle.body.font
        
        switch style {
        case .primary:
            backgroundColor = DS.Colors.primary
            setTitleColor(.white, for: .normal)
            spinner.color = .white
        case .secondary:
            backgroundColor = .clear
            setTitleColor(DS.Colors.primary, for: .normal)
            spinner.color = DS.Colors.primary
        }
        
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setIsLoading(_ isLoading: Bool) {
        isEnabled = !isLoading
        if isLoading {
            originalTitle = title(for: .normal)
            setTitle("", for: .normal)
            spinner.startAnimating()
            alpha = 0.7
        } else {
            setTitle(originalTitle, for: .normal)
            spinner.stopAnimating()
            alpha = 1.0
        }
    }
}
