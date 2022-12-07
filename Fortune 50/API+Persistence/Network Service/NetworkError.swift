//
//  NetworkError.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case dataFetchFailed
    case decodeError
}


extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidURL        : return "[ERROR] ⚠️: Looks like URL is not valid. Please check URL"
        case .dataFetchFailed   : return "[ERROR] ⚠️: Failed to Fetch Data from the given URL."
        case .decodeError       : return "[ERROR] ⚠️: Failed to Decode to Company Response Object."
        }
    }
}
