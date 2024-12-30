//
//  StubFetchDisneyCharactersPageService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubFetchDisneyCharactersPageService: FetchDisneyCharactersPageServiceProtocol {
    var result: Result<DisneyCharactersPage, ServiceError>?
    
    func fetch(
        keyword: String?,
        page: Int,
        pageSize: Int
    ) async -> Result<DisneyCharacters.DisneyCharactersPage, DisneyCharacters.ServiceError> {
        guard let result else { return .failure(.requestTimedOut) }
        return result
    }
    
    
}
