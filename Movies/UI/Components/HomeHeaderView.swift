//
//  HomeHeaderView.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct HomeHeaderView: View {
  @Binding var query: String
  var onSortTapped: () -> Void
  var onOrderTapped: () -> Void
  var onClearTapped: () -> Void
  
  var body: some View {
    VStack(spacing: 10) {
      SearchBar(query: $query)
      HStack {
        HeaderButton(
          icon: Image(systemName: "arrow.up.and.down.text.horizontal"),
          title: "sort_label".localized,
          onTapped: onSortTapped
        )
        .frame(maxWidth: .infinity)

        HeaderButton(
          icon: Image(systemName: "arrow.down"),
          title: "order_label".localized,
          iconFirst: false,
          onTapped: onOrderTapped
        )
        .frame(maxWidth: .infinity)
        HeaderButton(
          icon: Image(systemName: "arrow.trianglehead.counterclockwise"),
          title: "clear_label".localized,
          onTapped: onClearTapped
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
