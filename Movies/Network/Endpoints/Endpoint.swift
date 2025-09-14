//
//  Endpoint.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//
import Foundation

protocol Endpoint {
  var baseURL: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
  var method: String { get }
}

extension Endpoint {
  var url: URL? {
    var components = URLComponents(string: baseURL)
    components?.path = path
    components?.queryItems = queryItems.isEmpty ? nil : queryItems
    return components?.url
  }
}
