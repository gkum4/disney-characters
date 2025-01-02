//
//  StubDeleteFavoritedDisneyCharacterService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation
@testable import DisneyCharacters

final class StubDeleteFavoritedDisneyCharacterService:
    DeleteFavoritedDisneyCharacterServiceProtocol {
    var result: Result<Void, ServiceError>?
    
    func delete(by id: Int) async -> Result<Void, DisneyCharacters.ServiceError> {
        guard let result else { return .failure(.apiError) }
        return result
    }
}
