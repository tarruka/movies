//
//  HeaderButton.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct HeaderButton: View {
  
  var icon: Image
  var title: String
  var iconFirst: Bool = true
  var onTapped: () -> Void
  
  var body: some View {
    Button {
      onTapped()
    } label: {
      HStack(spacing: 5) {
        if iconFirst { icon }
        Text(title)
          .font(.caption)
          .fontWeight(.bold)
        if !iconFirst { icon }
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
    }.foregroundColor(.primary)
  }
}
