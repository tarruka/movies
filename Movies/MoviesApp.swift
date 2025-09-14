//
//  MoviesApp.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//

import SwiftUI

@main
struct MoviesApp: App {
  @StateObject private var movieStateManager = MovieStateManager()
    
  var body: some Scene {
    WindowGroup {
      NavigatorView {
        HomeView(viewModel: HomeViewModel())
      }
      .environmentObject(movieStateManager)
    }
  }
}
