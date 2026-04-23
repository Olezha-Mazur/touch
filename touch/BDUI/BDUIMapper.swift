//
//  BDUIMapper.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

protocol BDUIMapperProtocol {
    func map(node: BDUINode) -> UIView
}

final class BDUIMapper: BDUIMapperProtocol {
    private let actionHandler: BDUIActionHandlerProtocol
    
    init(actionHandler: BDUIActionHandlerProtocol) {
        self.actionHandler = actionHandler
    }
    
    func map(node: BDUINode) -> UIView {
        switch node.type {
            
            case .contentView:
                let view = UIView()
                view.backgroundColor = resolveColor(node.content?.backgroundColor)
                view.translatesAutoresizingMaskIntoConstraints = false
                
                if let childNode = node.subviews?.first {
                    let childView = map(node: childNode)
                    childView.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(childView)
                    
                    NSLayoutConstraint.activate([
                        childView.topAnchor.constraint(equalTo: view.topAnchor, constant: DS.Spacing.m),
                        childView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -DS.Spacing.m),
                        childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DS.Spacing.m),
                        childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DS.Spacing.m)
                    ])
                }
                return view
                
            case .stackView:
                let stack = UIStackView()
                stack.axis = node.content?.axis == "horizontal" ? .horizontal : .vertical
                stack.spacing = resolveSpacing(node.content?.spacing)
                
                if stack.axis == .horizontal {
                    stack.distribution = .fillEqually
                }
                
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                node.subviews?.forEach { childNode in
                    stack.addArrangedSubview(map(node: childNode))
                }
                return stack
                
            case .label:
                let label = UILabel()
                label.text = node.content?.text
                label.apply(resolveTextStyle(node.content?.textStyle))
                label.numberOfLines = 0
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
                
            case .button:
                let button = DSButton()
                let style: DSButton.Style = node.content?.buttonStyle == "secondary" ? .secondary : .primary
                let config = DSButton.Configuration(title: node.content?.text ?? "", style: style)
                button.configure(with: config)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight).isActive = true
                
                if let action = node.action {
                    button.addAction(UIAction { [weak self] _ in
                        self?.actionHandler.handle(action: action)
                    }, for: .touchUpInside)
                }
                return button
                
            case .textField:
                let tf = DSTextField(placeholderText: node.content?.placeholder ?? "")
                tf.translatesAutoresizingMaskIntoConstraints = false
                tf.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight).isActive = true
                return tf
                
            case .image:
                let iv = UIImageView()
                if let sysName = node.content?.systemImage { iv.image = UIImage(systemName: sysName) }
                iv.tintColor = DS.Colors.primary
                iv.contentMode = .scaleAspectFit
                iv.translatesAutoresizingMaskIntoConstraints = false
                iv.heightAnchor.constraint(equalToConstant: DS.Icons.Size.large * 2).isActive = true
                return iv
                
            case .errorView:
                let ev = DSErrorView()
                ev.translatesAutoresizingMaskIntoConstraints = false
                ev.configure(message: node.content?.text ?? "Ошибка", buttonTitle: "Повторить")
                if let action = node.action {
                    ev.retryButton.addAction(UIAction { [weak self] _ in
                        self?.actionHandler.handle(action: action)
                    }, for: .touchUpInside)
                }
                return ev
                
            case .spacer:
                let spacer = UIView()
                spacer.translatesAutoresizingMaskIntoConstraints = false
                spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
                spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
                return spacer
        }
    }

    
    private func resolveSpacing(_ token: String?) -> CGFloat {
        switch token {
            case "s": return DS.Spacing.s
            case "m": return DS.Spacing.m
            case "l": return DS.Spacing.l
            case "xl": return DS.Spacing.xl
            default: return 0
        }
    }
    
    private func resolveTextStyle(_ token: String?) -> DSTextStyle {
        switch token {
            case "title1": return .title1
            case "body": return .body
            case "caption": return .caption
            case "error": return .error
            default: return .body
        }
    }
    
    private func resolveColor(_ token: String?) -> UIColor {
        switch token {
            case "surface": return DS.Colors.surface
            case "background": return DS.Colors.background
            default: return .clear
        }
    }
}
