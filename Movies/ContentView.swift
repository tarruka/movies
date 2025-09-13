//
//  ContentView.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
  
    var body: some View {
      HomeView(viewModel: homeViewModel)
    }
}

#Preview {
    ContentView()
}
