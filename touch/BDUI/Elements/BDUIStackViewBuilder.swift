//
//  BDUIStackViewBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

final class BDUIStackViewBuilder: BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView {
        let stack = UIStackView()
        stack.axis = node.content?.axis == "horizontal" ? .horizontal : .vertical
        stack.spacing = DSUtils.resolveSpacing(node.content?.spacing)
        
        if stack.axis == .horizontal {
            stack.distribution = .fillEqually
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        node.subviews?.forEach { childNode in
            stack.addArrangedSubview(mapper.map(node: childNode))
        }
        return stack
    }
}
