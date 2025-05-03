//
//  RMCharecter.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [RMCharacter]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct RMCharacter: Codable, Identifiable {
      let id: Int
      let name: String
      let status: Status
      let species: String
      let type: String?
      let gender: String
      let origin: Location?  
      let location: Location?
      let image: String
      let episode: [String]
      let url: String
      let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Species: String, Codable {
    case human = "Human"
    case alien = "Alien"
    case unknown = "unknown"
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}
