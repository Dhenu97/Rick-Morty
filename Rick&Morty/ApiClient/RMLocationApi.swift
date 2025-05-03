//
//  RMLocationApi.swift
//  Rick&Morty
//
//  Created by dhenu on 4/29/25.
//

import Foundation

class RMLocationApi: LocationApi {
  var loc: [RMLocation] = []
  func fetchLocations() async throws -> LocationResponse {
    guard let url = URL(string: "\(ApiConstants.baseURL)\(Paths.location)") else {
      throw ErrorClass.invalidResponse
    }
    do {

      let response: LocationResponse = try await NetworkManager.shared.fetchData(from: url)
      let encoder = JSONEncoder()
      return response
    } catch {
      throw error
    }

  }


}
