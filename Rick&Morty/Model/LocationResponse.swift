//
//  RMLocation.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import Foundation


struct LocationResponse: Codable {
    let info: PageInfo
    let results: [RMLocation]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct RMLocation: Codable {
    let id: Int
    let name: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

struct RMLiteCharacter: Codable {
    let image: String
}

