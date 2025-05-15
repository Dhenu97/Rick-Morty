//
//  RMEpisodeApi.swift
//  Rick&Morty
//
//  Created by dhenu on 4/30/25.
//

import Foundation


final class RMEpisodeApi: EpisodeApiProtocol {
  func fetchInitialCharacters() async throws -> EpisodeResponse {
        guard let url = URL(string: "\(ApiConstants.baseURL)\(Paths.episode)") else {
            throw ErrorClass.invalidResponse
        }

    let response: EpisodeResponse = try await NetworkManager.shared.fetchData(from: url)
    print("jres\(response)")
        return response
    }
}


