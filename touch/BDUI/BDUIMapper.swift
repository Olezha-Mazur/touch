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
    private var builders: [BDUIElementType: BDUIElementBuilder] = [:]
    
    init(actionHandler: BDUIActionHandlerProtocol) {
        self.actionHandler = actionHandler
        registerDefaultBuilders()
    }
    
    func map(node: BDUINode) -> UIView {
        guard let builder = builders[node.type] else {
            print("[BDUIMapper]: Неизвестный тип элемента \(node.type). Возвращаю пустую UIView.")
            return UIView()
        }
        return builder.build(node: node, mapper: self, actionHandler: actionHandler)
    }
    
    private func registerDefaultBuilders() {
        builders[.contentView] = BDUIContentViewBuilder()
        builders[.stackView]   = BDUIStackViewBuilder()
        builders[.label]       = BDUILabelBuilder()
        builders[.button]      = BDUIButtonBuilder()
        builders[.image]       = BDUIImageBuilder()
        builders[.spacer]      = BDUISpacerBuilder()
        builders[.textField]   = BDUITextFieldBuilder()
    }
    
    func register(builder: BDUIElementBuilder, for type: BDUIElementType) {
        builders[type] = builder
    }
}

enum DSUtils {
    static func resolveSpacing(_ token: String?) -> CGFloat {
        switch token {
        case "s": return DS.Spacing.s
        case "m": return DS.Spacing.m
        case "l": return DS.Spacing.l
        case "xl": return DS.Spacing.xl
        default: return 0
        }
    }
    
    static func resolveTextStyle(_ token: String?) -> DSTextStyle {
        switch token {
        case "title1": return .title1
        case "body": return .body
        case "caption": return .caption
        case "error": return .error
        default: return .body
        }
    }
    
    static func resolveColor(_ token: String?) -> UIColor {
        switch token {
        case "surface": return DS.Colors.surface
        case "background": return DS.Colors.background
        default: return .clear
        }
    }
}

