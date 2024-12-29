//
//  HTTPTaskError.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

enum HTTPTaskError: Error {
    case networkError
    case timedOut
    case invalidHTTPResponse
    case generic
}
