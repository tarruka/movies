//
//  MovieStateManager.swift
//  Movies
//
//  Created by Tarek Radovan on 14/09/2025.
//

import Foundation

final class MovieStateManager: ObservableObject {
  @Published private(set) var states: [String: Bool] = [:]
  
  func isSelected(_ movie: Movie) -> Bool {
    states[movie.imdbID] ?? false
  }
  
  func toggle(_ movie: Movie) {
    states[movie.imdbID] = !(states[movie.imdbID] ?? false)
  }
  
  func clear() {
    states.removeAll()
  }
}
