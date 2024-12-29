//
//  StubFetchDisneyCharactersPageMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubFetchDisneyCharactersPageMapper: HTTPTaskResultMapperProtocol {
    var result: Result<DisneyCharactersPage, ServiceError>?
    
    func map(taskResult: HTTPTaskResult) -> Result<DisneyCharactersPage, ServiceError> {
        guard let result else { return .failure(.apiError) }
        return result
    }
}
