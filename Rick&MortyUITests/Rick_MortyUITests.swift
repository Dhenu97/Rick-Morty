//
//  Rick_MortyUITests.swift
//  Rick&MortyUITests
//
//  Created by dhenu on 3/12/25.
//

import XCTest

final class Rick_MortyUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

  func testtabBar() {
    let tabbarCharacterTest = app.tabBars.buttons["Charecters"]
    let tabbarLocationsest = app.tabBars.buttons["Locations"]
    let tabbarEpisodesTest = app.tabBars.buttons["Episodes"]
    XCTAssertTrue(tabbarCharacterTest.waitForExistence(timeout: 5))
    XCTAssertTrue(tabbarLocationsest.waitForExistence(timeout: 5))
    XCTAssertTrue(tabbarEpisodesTest.waitForExistence(timeout: 5))
    tabbarCharacterTest.tap()
    tabbarLocationsest.tap()
    tabbarEpisodesTest.tap()

  }

    func testCharacterNameLabelExists() {
        let characterNameLabel = app.staticTexts["characterName_Rick Sanchez"]
        let exists = characterNameLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The character name label should exist.")
    }

  func testAppLaunchesToCharacterGrid() {
      XCTAssertTrue(app.collectionViews.firstMatch.waitForExistence(timeout: 5))
  }

  func testTappingFirstCharacterCellOpensDetail() {
    let detailView = app.collectionViews.cells.element(boundBy: 0)
    XCTAssertTrue(detailView.waitForExistence(timeout: 5))
    detailView.tap()
  }

  func testCharacterDetailGrid() {
    XCTAssertTrue(app.collectionViews.cells.firstMatch.waitForExistence(timeout: 5))
  }


  func testLocationDetailGrid() {
    app.tabBars.buttons["Locations"].tap()
    XCTAssertTrue(app.collectionViews.firstMatch.waitForExistence(timeout: 5))
  }

}



