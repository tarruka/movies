//
//  NavigatorView.swift
//  Movies
//
//  Created by Tarek Radovan on 14/09/2025.
//

import SwiftUI

struct NavigatorView<Content: View>: View {
  @StateObject private var navigationManager = Navigator()
  let content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    NavigationStack(path: $navigationManager.path) {
      content
        .environmentObject(navigationManager)
        .navigationDestination(for: Destination.self) { destination in
          switch destination {
          case .home:
            EmptyView()
          case .movieDetail(let movie):
            MovieDetailView(movie: movie)
          }
        }
    }
  }
}
