//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by dhenu on 4/26/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

  func fetchData<T: Decodable>(from url: URL) async throws -> T {
      let (data, response) = try await URLSession.shared.data(from: url)

      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          throw ErrorClass.invalidResponse
      }

      do {

          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase  
          return try decoder.decode(T.self, from: data)
      } catch {
          throw ErrorClass.decodingFailed
      }
  }

}
