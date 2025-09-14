//
//  HomeHeaderView.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct HomeHeaderView: View {
  @Binding var query: String
  var sortType: SortType?
  var orderType: OrderType?
  var onSortTapped: () -> Void
  var onOrderTapped: () -> Void
  var onClearTapped: () -> Void
  
  var body: some View {
    VStack(spacing: 10) {
      SearchBar(query: $query)
      HStack(spacing: 8) {
        HeaderButton(
          type: .sort,
          sortType: sortType,
          onTapped: onSortTapped
        )
        .frame(maxWidth: .infinity)
        
        HeaderButton(
          type: .order,
          orderType: orderType,
          onTapped: onOrderTapped
        )
        .frame(maxWidth: .infinity)
        
        HeaderButton(
          type: .clear,
          onTapped: onClearTapped
        )
        .frame(maxWidth: .infinity)
      }
    }
    .padding(.horizontal, 10)
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
