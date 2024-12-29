//
//  URLSession+HTTPClientProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

extension URLSession: HTTPClientProtocol {
    func perform(request: URLRequest) async -> Result<HTTPTaskResult, HTTPTaskError> {
        let result: (Data, URLResponse)
        
        do {
            result = try await data(for: request)
        } catch let error as URLError {
            return .failure(handleURLError(error))
        } catch {
            return .failure(.generic)
        }
        
        guard let response = result.1 as? HTTPURLResponse else {
            return .failure(.invalidHTTPResponse)
        }
        
        return .success(HTTPTaskResult(data: result.0, response: response))
    }
    
    private func handleURLError(_ error: URLError) -> HTTPTaskError {
        switch error.code {
        case .networkConnectionLost, .notConnectedToInternet:
            return .networkError
        case .timedOut:
            return .timedOut
        default:
            return .generic
        }
    }
}
