//
//  RMLocationApi.swift
//  Rick&Morty
//
//  Created by dhenu on 4/29/25.
//

import Foundation

final class RMLocationApi: LocationApiProtocol {
  func fetchInitialCharacters() async throws -> LocationResponse {
        guard let url = URL(string: "\(ApiConstants.baseURL)\(Paths.location)") else {
            throw ErrorClass.invalidResponse
        }

    let response: LocationResponse = try await NetworkManager.shared.fetchData(from: url)
        return response
    }
}
