//
//  HomeViewModel.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
  
  var filteredMovies: [Movie] {
      guard !query.isEmpty else { return movies }
      return movies.filter { $0.title.localizedCaseInsensitiveContains(query) }
  }
  
  @Published var movies: [Movie] = []
  @Published var isLoading = false
  @Published var isLoadingMore = false
  @Published var query = ""
  @Published var sortField: SortField? = nil
  @Published var sortOrder: SortOrder = .ascending
  var cancellables = Set<AnyCancellable>()
  private let client = NetworkClient()
  private var currentPage = 1
  private var totalPages = 1

  func loadInitialMovies() async {
    currentPage = 1
    movies = []
    await loadMovies(page: currentPage, reset: true)
  }

  func loadMoreIfNeeded(currentItem movie: Movie?) async {
    guard let movie = movie else { return }
    let thresholdIndex = movies.index(movies.endIndex, offsetBy: -2)
    if movies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
      await loadNextPage()
    }
  }

  private func loadNextPage() async {
    guard !isLoadingMore, currentPage < totalPages else { return }
    currentPage += 1
    await loadMovies(page: currentPage)
  }

  private func loadMovies(page: Int, reset: Bool = false) async {
    if reset {
      isLoading = true
    } else {
      isLoadingMore = true
    }
    defer {
      isLoading = false
      isLoadingMore = false
    }

    do {
      let response = try await client.request(MoviesEndpoint.movies(page: page),
                                              as: MoviesResponse.self)
      totalPages = response.totalPages
      movies.append(contentsOf: response.data)
      applySorting()
    } catch {
      print("Error: \(error)")
    }
  }
  
  private func applySorting() {
    guard let field = sortField else { return }

    switch field {
    case .title:
      movies.sort { lhs, rhs in
        sortOrder == .ascending
        ? lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
        : lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedDescending
      }
    case .year:
      movies.sort { lhs, rhs in
        sortOrder == .ascending
        ? lhs.year < rhs.year
        : lhs.year > rhs.year
      }
    }
  }
  
  func sort() {
    sortField = sortField == .year ? .title : .year
    applySorting()
  }

  func toggleOrder() {
    sortOrder = (sortOrder == .ascending) ? .descending : .ascending
    applySorting()
  }

  func clearSort() async {
    query = ""
    sortField = nil
    sortOrder = .ascending
    await loadInitialMovies()
  }
}
