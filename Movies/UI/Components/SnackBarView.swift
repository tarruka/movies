//
//  SnackBarView.swift
//  Movies
//
//  Created by Tarek Radovan on 14/09/2025.
//

import SwiftUI

struct SnackbarView: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.white)
            Text(message)
                .foregroundColor(.white)
                .font(.caption)
                .lineLimit(2)
            Spacer()
        }
        .padding()
        .background(Color.red.opacity(0.9))
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}
