//
//  RMCharecterViewModel.swift
//  Rick&Morty
//
//  Created by dhenu on 4/27/25.
//

import Foundation

class RMCharecterViewModel {

    private(set) var characters: [RMCharacter] = []
    private(set) var nextPageUrl: URL?
    private var isLoadingMoreCharacters = false
    var onCharactersUpdated: (() -> Void)?

    func fetchInitialCharacters() {
        Task {
            do {
                let api = RMCharacterApi()
                let response: CharacterResponse = try await api.fetchCharacters()

                self.characters = response.results 
                if let nextString = response.info.next, let nextURL = URL(string: nextString) {
                    self.nextPageUrl = nextURL
                } else {
                    self.nextPageUrl = nil
                }

                DispatchQueue.main.async {
                    self.onCharactersUpdated?()
                }
            } catch {
                print("Failed to fetch characters: \(error)")
            }
        }
    }

    func fetchMoreCharacters() {
        guard let nextURL = nextPageUrl, !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
      print("ghfhvh\(nextURL)")
        Task {
            do {
                let response: CharacterResponse = try await NetworkManager.shared.fetchData(from: nextURL)

                self.characters.append(contentsOf: response.results)
              print(" Characters after appending: \(self.characters.count)")

                if let nextString = response.info.next, let nextURL = URL(string: nextString) {
                    self.nextPageUrl = nextURL
                } else {
                    self.nextPageUrl = nil
                }

                isLoadingMoreCharacters = false

                DispatchQueue.main.async {
                    self.onCharactersUpdated?()
                }
            } catch {
                print("Failed to fetch more characters: \(error)")
                isLoadingMoreCharacters = false
            }
        }
    }
}
