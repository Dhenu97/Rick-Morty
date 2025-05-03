//
//  LocationViewModel.swift
//  Rick&Morty
//
//  Created by dhenu on 4/29/25.
//

import Foundation



class LocationViewModel {
  private(set) var locationArray: [RMLocation] = []
  private(set) var nextPageUrl: URL?
  private var isLoadingMoreLocations = false
  var onLocationUpdated: (() -> Void)?

  func fetchInitialCharacters() {
      Task {
          do {
            let api = RMLocationApi()
            let response: LocationResponse = try await api.fetchLocations()

            self.locationArray = response.results
              if let nextString = response.info.next, let nextURL = URL(string: nextString) {
                  self.nextPageUrl = nextURL
              } else {
                  self.nextPageUrl = nil
              }

              DispatchQueue.main.async {
                (self.onLocationUpdated?())
              }
          } catch {
              print("Failed to fetch characters: \(error)")
          }
      }
  }

  func fetchMoreCharacters() {
    guard let nextURL = nextPageUrl, !isLoadingMoreLocations else { return }
    isLoadingMoreLocations = true
      Task {
          do {
            let response: LocationResponse = try await NetworkManager.shared.fetchData(from: nextURL)

            self.locationArray.append(contentsOf: response.results)

              if let nextString = response.info.next, let nextURL = URL(string: nextString) {
                  self.nextPageUrl = nextURL
              } else {
                  self.nextPageUrl = nil
              }

            isLoadingMoreLocations = false

              DispatchQueue.main.async {
                self.onLocationUpdated?()
              }
          } catch {
              print("Failed to fetch more characters: \(error)")
            isLoadingMoreLocations = false
          }
      }
  }

  func fetchCharacters(from urls: [String], completion: @escaping ([RMLiteCharacter]) -> Void) {
      let group = DispatchGroup()
      var characters: [RMLiteCharacter] = []
    // Decode first 10 charecters in 
      for url in urls.prefix(10) {
          guard let url = URL(string: url) else { continue }
          group.enter()
          URLSession.shared.dataTask(with: url) { data, _, _ in
              defer { group.leave() }
              if let data = data,
                 let character = try? JSONDecoder().decode(RMLiteCharacter.self, from: data) {
                  characters.append(character)
              }
          }.resume()
      }

      group.notify(queue: .main) {
          completion(characters)
      }
  }
}

