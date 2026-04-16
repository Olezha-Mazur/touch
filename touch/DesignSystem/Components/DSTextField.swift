//
//  DSTextField.swift
//  touch
//
//  Created by Oleg Mazur on 14.04.2026.
//

import UIKit

final class DSTextField: UITextField {
    init(placeholderText: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        placeholder = placeholderText
        isSecureTextEntry = isSecure
        
        backgroundColor = DS.Colors.surface
        layer.cornerRadius = DS.Spacing.cornerRadius
        font = DSTextStyle.body.font
        textColor = DS.Colors.textPrimary
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: DS.Spacing.m, height: 0))
        leftView = paddingView
        leftViewMode = .always
    }
    required init?(coder: NSCoder) { fatalError() }
}
