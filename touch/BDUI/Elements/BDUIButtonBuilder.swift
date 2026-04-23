//
//  BDUIButtonBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

final class BDUIButtonBuilder: BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView {
        let button = DSButton()
        let style: DSButton.Style = node.content?.buttonStyle == "secondary" ? .secondary : .primary
        let config = DSButton.Configuration(title: node.content?.text ?? "", style: style)
        button.configure(with: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight).isActive = true
        
        if let action = node.action {
            button.addAction(UIAction { _ in
                actionHandler.handle(action: action)
            }, for: .touchUpInside)
        }
        return button
    }
}
