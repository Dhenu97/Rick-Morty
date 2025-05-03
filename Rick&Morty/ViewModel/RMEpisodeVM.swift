//
//  RMEpisodeVM.swift
//  Rick&Morty
//
//  Created by dhenu on 4/30/25.
//

import Foundation


class RMEpisodeVM {

  private(set) var episodeArray: [RMEpisode] = []
  private(set) var nextPageUrl: URL?
  private var isLoadingMoreLocations = false

  var onEpisodeUpdated: (() -> Void)?

  func fetchInitialCharacters() {
    Task {
      do {
        let api = RMEpisodeApi()
        let response: EpisodeResponse = try await api.fetchEpisodes()

        self.episodeArray = response.results
        print("episodeArray\(episodeArray)")
        if let nextString = response.info.next, let nextURL = URL(string: nextString) {
          self.nextPageUrl = nextURL
        } else {
          self.nextPageUrl = nil
        }

        DispatchQueue.main.async {
          (self.onEpisodeUpdated?())
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
        let response: EpisodeResponse = try await NetworkManager.shared.fetchData(from: nextURL)
        self.episodeArray.append(contentsOf: response.results)

        if let nextString = response.info.next, let nextURL = URL(string: nextString) {
          self.nextPageUrl = nextURL
        } else {
          self.nextPageUrl = nil
        }

        isLoadingMoreLocations = false

        DispatchQueue.main.async {
          self.onEpisodeUpdated?()
        }
      } catch {
        print("Failed to fetch more characters: \(error)")
        isLoadingMoreLocations = false
      }
    }
  }

  func fetchCharacters(from urls: [String], completion: @escaping ([RMEpisodesCharacter]) -> Void) {
    let group = DispatchGroup()
    var characters: [RMEpisodesCharacter] = []

    for url in urls.prefix(10) {
      guard let url = URL(string: url) else { continue }
      group.enter()
      URLSession.shared.dataTask(with: url) { data, _, _ in
        defer { group.leave() }
        if let data = data,
           let character = try? JSONDecoder().decode(RMEpisodesCharacter.self, from: data) {
          characters.append(character)
        }
      }.resume()
    }

    group.notify(queue: .main) {
      completion(characters)
    }
  }

}
