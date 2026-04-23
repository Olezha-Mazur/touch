//
//  BDUIElementBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

protocol BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView
}
