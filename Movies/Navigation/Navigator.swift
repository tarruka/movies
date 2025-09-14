//
//  Navigator.swift
//  Movies
//
//  Created by Tarek Radovan on 14/09/2025.
//

import SwiftUI

final class Navigator: ObservableObject {
  @Published var path = NavigationPath()
  
  func push(_ destination: Destination) {
    path.append(destination)
  }
  
  func pop() {
    guard !path.isEmpty else { return }
    path.removeLast()
  }
  
  func popToRoot() {
    path.removeLast(path.count)
  }
}
