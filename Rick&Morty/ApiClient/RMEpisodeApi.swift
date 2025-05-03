//
//  RMEpisodeApi.swift
//  Rick&Morty
//
//  Created by dhenu on 4/30/25.
//

import Foundation


class RMEpisodeApi: EpisodeApi {

  func fetchEpisodes() async throws -> EpisodeResponse {
    guard let url = URL(string: "\(ApiConstants.baseURL)\(Paths.episode)") else {
      throw ErrorClass.invalidResponse
    }
    do {

      let response: EpisodeResponse = try await NetworkManager.shared.fetchData(from: url)
      let encoder = JSONEncoder()
      return response
    } catch {
      throw error
    }

  }


}
