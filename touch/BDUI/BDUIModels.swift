//
//  BDUIModels.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import Foundation

enum BDUIElementType: String, Decodable {
    case contentView
    case stackView
    case label
    case button
    case textField
    case image
    case spacer
}

enum BDUIActionType: String, Decodable {
    case print
    case route
    case reload
}

struct BDUIAction: Decodable {
    let type: BDUIActionType
    let context: [String: String]?
}

struct BDUIContent: Decodable {
    let text: String?
    let placeholder: String?
    let axis: String?
    let spacing: String?
    let textStyle: String?
    let buttonStyle: String?
    let backgroundColor: String?
    let systemImage: String?
}

struct BDUINode: Decodable {
    let type: BDUIElementType
    let content: BDUIContent?
    let action: BDUIAction?
    let subviews: [BDUINode]?
}
