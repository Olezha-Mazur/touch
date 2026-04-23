//
//  DSTokens.swift
//  touch
//
//  Created by Oleg Mazur on 14.04.2026.
//

import UIKit

enum DS {
    enum Colors {
        static let background = UIColor.systemBackground
        static let surface = UIColor.systemGray6
        static let primary = UIColor.systemBlue
        static let textPrimary = UIColor.label
        static let textSecondary = UIColor.secondaryLabel
        static let error = UIColor.systemRed
    }

    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
        
        static let cornerRadius: CGFloat = 12
        
        static let controlHeight: CGFloat = 48
    }
    
    enum Icons {
        static let error = UIImage(systemName: "exclamationmark.triangle")
        static let empty = UIImage(systemName: "tray")
        static let search = UIImage(systemName: "magnifyingglass")
        
        static let feed = UIImage(systemName: "list.bullet.rectangle")
        static let profile = UIImage(systemName: "person.crop.circle")
        
        enum Size {
            static let small: CGFloat = 16
            static let medium: CGFloat = 24
            static let large: CGFloat = 48
        }
    }
}

enum DSTextStyle {
    case title1
    case title2
    case body
    case caption
    case error
    
    var font: UIFont {
        switch self {
        case .title1: return .systemFont(ofSize: 32, weight: .bold)
        case .title2: return .systemFont(ofSize: 20, weight: .semibold)
        case .body: return .systemFont(ofSize: 16, weight: .regular)
        case .caption: return .systemFont(ofSize: 13, weight: .regular)
        case .error: return .systemFont(ofSize: 14, weight: .medium)
        }
    }
    
    var color: UIColor {
        switch self {
        case .title1, .title2, .body: return DS.Colors.textPrimary
        case .caption: return DS.Colors.textSecondary
        case .error: return DS.Colors.error
        }
    }
}

extension UILabel {
    func apply(_ style: DSTextStyle) {
        self.font = style.font
        self.textColor = style.color
    }
}
