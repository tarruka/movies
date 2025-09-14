//
//  NetworkClientMock.swift
//  Movies
//
//  Created by Tarek Radovan on 14/09/2025.
//

import Foundation
@testable import Movies

final class NetworkClientMock: NetworkClientProtocol {
  var responses: [Int: Data] = [:]
  var error: Error?

  func request<T>(_ endpoint: Endpoint, as type: T.Type) async throws -> T where T : Decodable {
    if let error = error {
      throw error
    }

    if let moviesEndpoint = endpoint as? MoviesEndpoint {
      switch moviesEndpoint {
      case .movies(let page):
        if let data = responses[page] {
          return try JSONDecoder().decode(T.self, from: data)
        }
      }
    }

    throw URLError(.badServerResponse)
  }
}
