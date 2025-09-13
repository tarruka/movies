//
//  Movie.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//
import Foundation

struct Movie: Identifiable, Codable {
    let title: String
    let year: Int
    let imdbID: String

    var id: String { imdbID }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
    }
}

struct MoviesResponse: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}
