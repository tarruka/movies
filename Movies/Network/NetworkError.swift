//
//  NetworkError.swift
//  Movies
//
//  Created by Tarek Radovan on 12/09/2025.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed(Error)
    case unknown
}
