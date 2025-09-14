//
//  MovieDetailView.swift
//  Movies
//
//  Created by Tarek Radovan on 14/09/2025.
//

import SwiftUI

struct MovieDetailView: View {
  let movie: Movie
  
  @EnvironmentObject private var movieStateManager: MovieStateManager
  
  var body: some View {
    VStack(spacing: 20) {
      Text(movie.title)
        .font(.title)
        .bold()
      
      Text("\(movie.year)")
        .font(.headline)
      
      Text("id_label \(movie.imdbID)")
        .font(.subheadline)
      
      Button(action: {
        movieStateManager.toggle(movie)
      }) {
        Text(movieStateManager.isSelected(movie) ? "remove_label" : "select_label")
          .padding()
          .frame(maxWidth: .infinity)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .fill(movieStateManager.isSelected(movie) ? Color.red : Color.blue)
          )
          .foregroundColor(.white)
      }
      .accessibilityIdentifier("toggleButton")
      
      Spacer()
    }
    .padding()
  }
}
