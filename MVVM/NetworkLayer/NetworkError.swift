//
//  NetworkError.swift
//  MVVM
//
//  Created by Kannan Prasad on 24/01/2021.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case unauthorisedResponse
    case httpErrorResponse
    case jsonParsingFailure
    case invalidURL
    case customError(message:String)

    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .unauthorisedResponse: return "Unauthorised web service access"
        case .httpErrorResponse: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .invalidURL: return "Invalid URL"
        case .customError(let message): return "\(message)"
        }
    }
}
