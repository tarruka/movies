//
//  MovieCard.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct MovieCard: View {
  
  var movie: Movie
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(movie.title)
          .fontWeight(.bold)
          .accessibilityIdentifier("name")
          .padding(.bottom, 10)
      HStack {
        Image(systemName: "calendar")
        Text("\(movie.year)")
            .accessibilityIdentifier("year")
        Spacer()
        Image(systemName: "clock")
        Text("id_label \(movie.imdbID)")
            .accessibilityIdentifier("imdb")
      }
     
    }
    .foregroundColor(.primary)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 16)
        .stroke(Color.secondary, lineWidth: 1)
        .background(
          Color(UIColor.systemBackground).cornerRadius(16)
        )
    )
    .accessibilityElement(children: .combine)
    .accessibilityIdentifier("movie-item")
  }
}
