//
//  BDUIContentViewBuilder.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

final class BDUIContentViewBuilder: BDUIElementBuilder {
    func build(node: BDUINode, mapper: BDUIMapperProtocol, actionHandler: BDUIActionHandlerProtocol) -> UIView {
        let view = UIView()
        view.backgroundColor = DSUtils.resolveColor(node.content?.backgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let childNode = node.subviews?.first {
            let childView = mapper.map(node: childNode)
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
    }
}
