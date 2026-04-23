//
//  BDUILabelBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

final class BDUILabelBuilder: BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView {
        let label = UILabel()
        label.text = node.content?.text
        label.apply(DSUtils.resolveTextStyle(node.content?.textStyle))
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
