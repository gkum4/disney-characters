//
//  StubHTTPClient.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubHTTPClient: HTTPClientProtocol {
    var result: Result<HTTPTaskResult, HTTPTaskError>?
    
    func perform(request: URLRequest) async -> Result<DisneyCharacters.HTTPTaskResult, DisneyCharacters.HTTPTaskError> {
        guard let result else { return .failure(.generic) }
        
        return result
    }
}

