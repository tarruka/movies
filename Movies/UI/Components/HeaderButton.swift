//
//  HeaderButton.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

enum SortType {
  case title
  case year
}

enum OrderType {
  case ascending
  case descending
}

struct HeaderButton: View {
  var type: ButtonType
  var sortType: SortType? = nil
  var orderType: OrderType? = nil
  var onTapped: () -> Void
  
  enum ButtonType {
    case sort
    case order
    case clear
  }
  
  var body: some View {
      Button(action: onTapped) {
        HStack(spacing: 5) {
          if type != .order {
           icon
          }
          Text(label)
            .font(.caption)
            .fontWeight(.bold)
          if type == .order {
            icon
          }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 40)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(UIColor.systemGray5))
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color(UIColor.separator), lineWidth: 1)
            )
        )
      }
      .foregroundColor(.primary)
      .accessibilityIdentifier(identifier)
  }
  
  private var shouldShowIcon: Bool {
    switch type {
    case .sort:
      return sortType != nil
    case .order:
      return orderType != nil
    case .clear:
      return true
    }
  }
  
  private var icon: Image {
    switch type {
    case .sort:
      if shouldShowIcon {
        return Image(systemName: sortType == .title ? "textformat.abc" : "calendar")
      } else {
        return Image(systemName: "line.3.horizontal")
      }
    case .order:
      if shouldShowIcon {
        return Image(systemName: orderType == .ascending ? "arrow.up" : "arrow.down")
      } else {
        return Image(systemName: "arrow.up.arrow.down")
      }
    case .clear:
      return Image(systemName: "arrow.trianglehead.counterclockwise")
    }
  }
  
  private var label: LocalizedStringKey {
    switch type {
    case .sort: return "sort_label"
    case .order: return "order_label"
    case .clear: return "reset_label"
    }
  }
  
  private var identifier: String {
    switch type {
    case .sort: return "sortToggleButton"
    case .order: return "orderToggleButton"
    case .clear: return "clearSortButton"
    }
  }
}
