//
//  Rick_MortyTests.swift
//  Rick&MortyTests
//
//  Created by dhenu on 3/12/25.
//

import Testing
@testable import Rick_Morty
import XCTest

struct Rick_MortyTests {

  @Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
  }

}

final class RMCharacterViewModelTests: XCTestCase {

  var charVm: RMCharecterViewModel?

  override func setUp() {
    charVm = RMCharecterViewModel()
  }

  override func tearDownWithError() throws {
    charVm = nil
  }

  func testOnCharacterClosureFetched() {
    let exception = XCTestExpectation(description: "onCharactersUpdated should be called")
    charVm?.onCharactersUpdated = {
      exception.fulfill()
    }

    DispatchQueue.main.async {
      self.charVm?.onCharactersUpdated?()
    }

    wait(for: [exception], timeout: 5)
  }

}


