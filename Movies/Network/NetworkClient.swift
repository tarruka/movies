//
//  NetworkClient.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//
import Foundation

final class NetworkClient {
  func request<T: Decodable>(
    _ endpoint: Endpoint,
    as type: T.Type
  ) async throws -> T {
    guard let url = endpoint.url else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.unknown
    }

    guard (200..<300).contains(httpResponse.statusCode) else {
      if let backendError = try? JSONDecoder().decode(
        BackendErrorResponse.self, from: data
      ) {
        throw NetworkError.backendError(message: backendError.error)
      } else {
        throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
      }
    }

    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw NetworkError.decodingFailed(error)
    }
  }
}
