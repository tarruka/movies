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
  case backendError(message: String)
  case unknown
}

extension NetworkError {
  var userMessage: String {
    switch self {
    case .invalidURL:
      return "Invalid request. Please contact support."
    case .requestFailed(let statusCode):
      switch statusCode {
      case 401: return "Unauthorized. Please log in again."
      case 404: return "Data not found."
      case 500: return "Server error. Please try later."
      default:  return "Request failed with code \(statusCode)."
      }
    case .decodingFailed:
      return "We couldn't process the data. Try again."
    case .backendError(let message):
      return message
    case .unknown:
      return "Something went wrong. Please try again."
    }
  }
}
