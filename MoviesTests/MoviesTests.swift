//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Tarek Radovan on 12/09/2025.
//

import XCTest
@testable import Movies

final class MoviesTests: XCTestCase {
  
  // MARK: - Helpers JSON
  
  private let page1JSON = """
  {
    "page": 1,
    "per_page": 2,
    "total": 4,
    "total_pages": 2,
    "data": [
      { "Title": "Movie A", "Year": 2000, "imdbID": "1" },
      { "Title": "Movie B", "Year": 2001, "imdbID": "2" }
    ]
  }
  """.data(using: .utf8)!
  
  private let page2JSON = """
  {
    "page": 2,
    "per_page": 2,
    "total": 4,
    "total_pages": 2,
    "data": [
      { "Title": "Movie C", "Year": 2002, "imdbID": "3" },
      { "Title": "Movie D", "Year": 2003, "imdbID": "4" }
    ]
  }
  """.data(using: .utf8)!
  
  // MARK: - Sorting
  
  func test_sortByTitleAscending() async {
    let movies = [
      Movie(title: "Zebra", year: 2001, imdbID: "1"),
      Movie(title: "Apple", year: 1999, imdbID: "2")
    ]
    
    let viewModel = await HomeViewModel(client: NetworkClientMock())
    await MainActor.run {
      viewModel.movies = movies
      viewModel.sortType = .title
      viewModel.orderType = .ascending
      viewModel.applySorting()
      
      XCTAssertEqual(viewModel.movies.first?.title, "Apple")
    }
  }
  
  func test_sortByTitleDescending() async {
    let movies = [
      Movie(title: "Zebra", year: 2001, imdbID: "1"),
      Movie(title: "Apple", year: 1999, imdbID: "2")
    ]
    
    let viewModel = await HomeViewModel(client: NetworkClientMock())
    await MainActor.run {
      viewModel.movies = movies
      viewModel.sortType = .title
      viewModel.orderType = .descending
      viewModel.applySorting()
      
      XCTAssertEqual(viewModel.movies.first?.title, "Zebra")
    }
  }
  
  func test_sortByYearAscending() async {
    let movies = [
      Movie(title: "Old", year: 1980, imdbID: "1"),
      Movie(title: "New", year: 2020, imdbID: "2")
    ]
    
    let viewModel = await HomeViewModel(client: NetworkClientMock())
    await MainActor.run {
      viewModel.movies = movies
      viewModel.sortType = .year
      viewModel.orderType = .ascending
      viewModel.applySorting()
      
      XCTAssertEqual(viewModel.movies.first?.year, 1980)
    }
  }
  
  func test_sortByYearDescending() async {
    let movies = [
      Movie(title: "Old", year: 1980, imdbID: "1"),
      Movie(title: "New", year: 2020, imdbID: "2")
    ]
    
    let viewModel = await HomeViewModel(client: NetworkClientMock())
    await MainActor.run {
      viewModel.movies = movies
      viewModel.sortType = .year
      viewModel.orderType = .descending
      viewModel.applySorting()
      
      XCTAssertEqual(viewModel.movies.first?.year, 2020)
    }
  }
  
  // MARK: - Search
  
  func test_searchFiltersMovies() async {
    let movies = [
      Movie(title: "Matrix", year: 1999, imdbID: "1"),
      Movie(title: "Inception", year: 2010, imdbID: "2")
    ]
    
    let viewModel = await HomeViewModel(client: NetworkClientMock())
    await MainActor.run {
      viewModel.movies = movies
      viewModel.query = "Matrix"
      
      XCTAssertEqual(viewModel.filteredMovies.count, 1)
      XCTAssertEqual(viewModel.filteredMovies.first?.title, "Matrix")
    }
  }
  
  // MARK: - Pagination
  
  func test_paginationLoadsNextPage() async throws {
    let mock = NetworkClientMock()
    mock.responses = [
      1: page1JSON,
      2: page2JSON
    ]
    
    let viewModel = await HomeViewModel(client: mock)
    
    // Load first page
    await viewModel.loadInitialMovies()
    
    await MainActor.run {
      XCTAssertEqual(viewModel.movies.count, 2)
      XCTAssertEqual(viewModel.movies.first?.title, "Movie A")
    }
    
    // Simulate scroll to last
    let lastMovie = await MainActor.run { viewModel.movies.last }
    await viewModel.loadMoreIfNeeded(currentItem: lastMovie)
    
    await MainActor.run {
      XCTAssertEqual(viewModel.movies.count, 4)
      XCTAssertEqual(viewModel.movies.last?.title, "Movie D")
    }
  }
  
  // MARK: - Parsing JSON
  
  func test_parseMovieResponse() throws {
    let json = """
    {
      "page": 1,
      "per_page": 10,
      "total": 1,
      "total_pages": 1,
      "data": [
        { "Title": "Matrix", "Year": 1999, "imdbID": "tt0133093" }
      ]
    }
    """.data(using: .utf8)!
    
    let response = try JSONDecoder().decode(MoviesResponse.self, from: json)
    XCTAssertEqual(response.data.first?.title, "Matrix")
    XCTAssertEqual(response.data.first?.year, 1999)
  }
}
