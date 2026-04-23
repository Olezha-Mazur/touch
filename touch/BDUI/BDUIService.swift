//
//  BDUIService.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import Foundation

protocol BDUIServiceProtocol {
    func fetchScreen() async throws -> BDUINode
}

final class BDUIService: BDUIServiceProtocol {
    private var reloadCount = 0
    
    func fetchScreen() async throws -> BDUINode {
        try await Task.sleep(nanoseconds: 800_000_000)
        
        guard let url = Bundle.main.url(forResource: "PostDetailsBDUI", withExtension: "json") else {
            throw AppError.networkError
        }
        
        let data = try Data(contentsOf: url)
        var rootNode = try JSONDecoder().decode(BDUINode.self, from: data)
        reloadCount += 1
        if reloadCount > 1 {
            if let firstStack = rootNode.subviews?.first,
               var textLabels = firstStack.subviews {
                var titleNode = textLabels[1]
                let newContent = BDUIContent(
                    text: "Backend-Driven UI (Обновление \(reloadCount))",
                    placeholder: titleNode.content?.placeholder,
                    axis: titleNode.content?.axis,
                    spacing: titleNode.content?.spacing,
                    textStyle: titleNode.content?.textStyle,
                    buttonStyle: titleNode.content?.buttonStyle,
                    backgroundColor: titleNode.content?.backgroundColor,
                    systemImage: titleNode.content?.systemImage
                )
                titleNode = BDUINode(type: titleNode.type, content: newContent, action: titleNode.action, subviews: titleNode.subviews)
                textLabels[1] = titleNode
                let newFirstStack = BDUINode(type: firstStack.type, content: firstStack.content, action: firstStack.action, subviews: textLabels)
                rootNode = BDUINode(type: rootNode.type, content: rootNode.content, action: rootNode.action, subviews: [newFirstStack])
            }
        }
        return rootNode
    }
}
