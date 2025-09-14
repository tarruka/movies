//
//  HomeView.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject private var viewModel: HomeViewModel
  @EnvironmentObject private var navigator: Navigator

  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      VStack {
        HomeHeaderView(
          query: $viewModel.query,
          sortType: viewModel.sortType,
          orderType: viewModel.orderType,
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

        List {
          ForEach(viewModel.filteredMovies) { movie in
            MovieCard(movie: movie)
              .onTapGesture {
                navigator.push(.movieDetail(movie))
              }
              .listRowInsets(EdgeInsets(
                top: 0, leading: 0, bottom: 10, trailing: 0
              ))
              .listRowBackground(Color.clear)
              .onAppear {
                Task { await viewModel.loadMoreIfNeeded(currentItem: movie) }
              }
          }

          if viewModel.isLoadingMore {
            ProgressView()
              .accessibilityIdentifier("load-more-progress")
              .frame(maxWidth: .infinity, alignment: .center)
              .listRowSeparator(.hidden)
              .listRowInsets(EdgeInsets())
              .listRowBackground(Color.clear)
          }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .padding(.horizontal, 10)
        .accessibilityIdentifier("movie-list")
      }
      .background(Color(UIColor.systemBackground).ignoresSafeArea())
      .overlay(
        VStack {
          if let message = viewModel.errorMessage {
            SnackbarView(message: message)
              .transition(.move(edge: .top).combined(with: .opacity))
              .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                  withAnimation {
                    viewModel.errorMessage = nil
                  }
                }
              }
          }
          Spacer()
        }
        .animation(.easeInOut, value: viewModel.errorMessage)
      )
      .overlay {
        if viewModel.isLoading {
          ProgressView()
            .foregroundStyle(.primary)
        }
      }
      .task {
        await viewModel.loadInitialMovies()
      }
      .navigationTitle("movie_list")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
