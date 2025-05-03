//
//  RMCharecterApi.swift
//  Rick&Morty
//
//  Created by dhenu on 4/26/25.
//

import Foundation

final class RMCharacterApi: CharacterApi {
  func fetchCharacters() async throws -> CharacterResponse {
    guard let url = URL(string: "\(ApiConstants.baseURL)\(Paths.character)") else {
      throw ErrorClass.invalidResponse
    }
    do {

      let response: CharacterResponse = try await NetworkManager.shared.fetchData(from: url)
      let encoder = JSONEncoder()
      return response
    } catch {
      throw error
    }
  }
}
