//
//  ServiceError.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

enum ServiceError: Error {
    case encodeError
    case decodeError
    case serverError(statusCode: Int)
    case requestTimedOut
    case noInternetConnection
    case invalidRequest
    case apiError
    case notFound
}

extension ServiceError: Equatable {}
