//
//  CoinAPIError.swift
//  NetworkingTutorial
//
//  Created by lexi sanders on 12/26/23.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData: return "Invalid data"
        case .jsonParsingFailure: return "Failed to parse data"
        case .requestFailed(let description): return "Request failed: \(description)"
        case .invalidStatusCode(let statusCode): return "Invalid status code: \(statusCode)"
        case .unknownError(let error): return "An unknown error occured \(error.localizedDescription)"
        }
    }
}
