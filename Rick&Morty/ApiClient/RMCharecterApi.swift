//
//  RMCharecterApi.swift
//  Rick&Morty
//
//  Created by dhenu on 4/26/25.
//

import Foundation

final class RMCharacterApi: CharacterApiProtocol {
    func fetchInitialCharacters() async throws -> CharacterResponse {
        guard let url = URL(string: "\(ApiConstants.baseURL)\(Paths.character)") else {
            throw ErrorClass.invalidResponse
        }

        let response: CharacterResponse = try await NetworkManager.shared.fetchData(from: url)
        return response
    }
}
