//
//  ApiConstants.swift
//  Rick&Morty
//
//  Created by dhenu on 4/26/25.
//

import Foundation


struct ApiConstants {
  static let baseURL = "https://rickandmortyapi.com/api"
  
}

struct Paths {

  static let character = "/character"
  static let location = "/location"
  static let episode = "/episode"
}



// protocols

protocol CharacterApi {
    func fetchCharacters() async throws -> CharacterResponse
}

protocol LocationApi {
    func fetchLocations() async throws -> LocationResponse
}

protocol EpisodeApi {
  func fetchEpisodes() async throws -> EpisodeResponse
}
