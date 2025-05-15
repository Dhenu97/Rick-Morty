//
//  RMCharacterIntegrationTests.swift
//  Rick&MortyTests
//
//  Created by dhenu on 5/15/25.
//

import Testing
import XCTest
@testable import Rick_Morty
// Integration test
class MockApi: CharacterApiProtocol {
  func fetchInitialCharacters() async throws -> CharacterResponse {
    return CharacterResponse(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [

      RMCharacter(id: 1, name: "Rick", status: Status(rawValue: "Alive") ?? .alive, species: "Human", gender: "Male",
                  origin: Location(name: "Earth", url: ""),
                  location: Location(name: "Earth", url: ""),
                  image: "", episode: [], url: "", created: ""),
      RMCharacter(id: 2, name: "Morty", status: Status(rawValue: "Dead") ?? .alive, species: "Human", gender: "Male",
                  origin: Location(name: "Earth", url: ""),
                  location: Location(name: "Earth", url: ""),
                  image: "", episode: [], url: "", created: "")

    ])

  }

}

final class RMCharacterIntegrationTests: XCTestCase {

    func testFetchInitialCharacters_Integration() async {
        let viewModel = RMCharecterViewModel(characterApi: MockApi())

        let expectation = XCTestExpectation(description: "onCharactersUpdated should be called")

        viewModel.onCharactersUpdated = {
            XCTAssertEqual(viewModel.characters.count, 2)
            XCTAssertEqual(viewModel.characters.first?.name, "Rick")
            XCTAssertEqual(viewModel.characters.last?.name, "Morty")
            expectation.fulfill()
        }

        viewModel.fetchInitialCharacters()
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
