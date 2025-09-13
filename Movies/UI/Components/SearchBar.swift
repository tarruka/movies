//
//  SearchBar.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct SearchBar: View {
  
  @Binding var query: String
  
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(.secondary)
      TextField(
        text: $query,
        prompt: Text("search_movies_placeholder").foregroundColor(.secondary)
      ) { }
      .foregroundColor(.primary)
    }
    .padding(.horizontal)
    .padding(.vertical, 5)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.secondary, lineWidth: 1)
    )
  }
}
