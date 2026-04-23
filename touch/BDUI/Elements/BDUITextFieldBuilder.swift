//
//  BDUITextFieldBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

final class BDUITextFieldBuilder: BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView {
        let tf = DSTextField(placeholderText: node.content?.placeholder ?? "")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: DS.Spacing.controlHeight).isActive = true
        return tf
    }
}
