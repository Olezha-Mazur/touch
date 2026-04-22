//
//  DTOs.swift
//  touch
//
//  Created by Oleg Mazur on 26.03.2026.
//

import Foundation

struct PostDTO: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
