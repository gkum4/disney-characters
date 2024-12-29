//
//  ServiceTaskErrorMapper.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

final class ServiceTaskErrorMapper: HTTPTaskErrorMapperProtocol {
    func map(taskError: HTTPTaskError) -> ServiceError {
        switch taskError {
        case .networkError:
            return .noInternetConnection
        case .timedOut:
            return .requestTimedOut
        case .invalidHTTPResponse, .generic:
            return .apiError
        }
    }
}
