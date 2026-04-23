//
//  BDUIImageBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

final class BDUIImageBuilder: BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView {
        let iv = UIImageView()
        if let sysName = node.content?.systemImage { iv.image = UIImage(systemName: sysName) }
        iv.tintColor = DS.Colors.primary
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: DS.Icons.Size.large * 2).isActive = true
        return iv
    }
}
