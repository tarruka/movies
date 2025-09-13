//
//  HomeHeaderView.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct HomeHeaderView: View {
  @Binding var query: String
  
  var body: some View {
    VStack(spacing: 10) {
      SearchBar(query: $query)
      HStack {
        HeaderButton(
          icon: Image(systemName: "arrow.up.and.down.text.horizontal"),
          title: "Sort",
          onTapped: {
            //
          }
        )
        .frame(maxWidth: .infinity)

        HeaderButton(
          icon: Image(systemName: "arrow.down"),
          title: "Order",
          iconFirst: false,
          onTapped: {
            //
          }
        )
        .frame(maxWidth: .infinity)
        HeaderButton(
          icon: Image(systemName: "arrow.trianglehead.counterclockwise"),
          title: "Clear",
          onTapped: {
            //
          }
        )
        .frame(maxWidth: .infinity)
      }
    }
    .padding(.horizontal)
    .background(
      LinearGradient(
        colors: [
          Color.darkBlue,
          Color(UIColor.systemBackground)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea(edges: [.top, .horizontal])
    )
  }
}
