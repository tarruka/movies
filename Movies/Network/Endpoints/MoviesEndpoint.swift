//
//  MoviesEndpoint.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//
import Foundation

enum MoviesEndpoint: Endpoint {
    case movies(page: Int)

    var baseURL: String { "https://jsonmock.hackerrank.com" }

    var path: String {
        switch self {
        case .movies: return "/api/moviesdata"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .movies(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }

    var method: String { "GET" }
}
