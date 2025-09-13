//
//  HomeView.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject private var viewModel: HomeViewModel
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      VStack {
        HomeHeaderView(
          query: $viewModel.query,
          onSortTapped: {
            viewModel.sort()
          },
          onOrderTapped: {
            viewModel.toggleOrder()
          },
          onClearTapped: {
            Task {
              await viewModel.clearSort()
            }
          }
        )
        ScrollView {
          LazyVStack {
            ForEach(viewModel.filteredMovies) { movie in
              MovieCard(movie: movie)
                .onAppear {
                  Task {
                    await viewModel.loadMoreIfNeeded(currentItem: movie)
                  }
                }
            }
            if viewModel.isLoadingMore {
              ProgressView()
                .accessibilityIdentifier("load-more-progress")
                .frame(maxWidth: .infinity, alignment: .center)
            }
          }
          .scrollContentBackground(.hidden)
        }.padding(.horizontal)
      }
     
      .background(Color(UIColor.systemBackground).ignoresSafeArea())
      .accessibilityIdentifier("movie-list")
      .overlay {
        if viewModel.isLoading {
          ProgressView()
        }
      }
      .task {
        await viewModel.loadInitialMovies()
      }
      .navigationTitle("movie_list")
      .navigationBarTitleDisplayMode(.inline)
      .accessibilityIdentifier("header-title")
    }
  }
}

