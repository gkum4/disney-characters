//
//  StubFetchDisneyCharacterService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation
@testable import DisneyCharacters

final class StubFetchDisneyCharacterService: FetchDisneyCharacterServiceProtocol {
    var result: Result<DisneyCharacter, ServiceError>?
    
    func fetch(id: Int) async -> Result<DisneyCharacter, ServiceError> {
        guard let result else { return .failure(.apiError) }
        return result
    }
    
    
}
