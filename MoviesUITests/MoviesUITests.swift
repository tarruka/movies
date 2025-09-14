//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Tarek Radovan on 12/09/2025.
//

import XCTest

final class MoviesUITests: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
    print(app.debugDescription)
  }
  
  // MARK: - Movie List Rendering
  
  func test_movieListRendersItems() throws {
    // Wait until the movie list exists
    let movieList = app.collectionViews["movie-list"]
    XCTAssertTrue(movieList.waitForExistence(timeout: 5))
    
    // Verify that at least one movie item is rendered
    let firstItem = app.staticTexts["name"].firstMatch
    XCTAssertTrue(firstItem.waitForExistence(timeout: 5))
    
    // Check that required labels exist inside the movie item
    XCTAssertTrue(firstItem.exists)
    XCTAssertTrue(app.staticTexts["year"].exists)
    XCTAssertTrue(app.staticTexts["imdb"].exists)
  }
  
  // MARK: - Sort Buttons
  
  func test_sortButtonsExist() throws {
    // Check that all sort-related buttons exist
    let sortButton = app.buttons["sortToggleButton"]
    let orderButton = app.buttons["orderToggleButton"]
    let clearButton = app.buttons["clearSortButton"]
    
    XCTAssertTrue(sortButton.waitForExistence(timeout: 5))
    XCTAssertTrue(orderButton.exists)
    XCTAssertTrue(clearButton.exists)
  }
  
  func test_tapSortButton() throws {
    let sortButton = app.buttons["sortToggleButton"]
    XCTAssertTrue(sortButton.waitForExistence(timeout: 5))
    sortButton.tap()
  }
}
