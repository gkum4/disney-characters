//
//  StubFetchDisneyCharacterMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubFetchDisneyCharacterMapper: HTTPTaskResultMapperProtocol {
    var result: Result<DisneyCharacter, ServiceError>?
    
    func map(taskResult: HTTPTaskResult) -> Result<DisneyCharacter, ServiceError> {
        guard let result else { return .failure(.apiError) }
        return result
    }
}
