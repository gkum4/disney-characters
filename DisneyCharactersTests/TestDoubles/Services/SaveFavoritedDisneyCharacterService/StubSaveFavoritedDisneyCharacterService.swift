//
//  StubSaveFavoritedDisneyCharacterService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation
@testable import DisneyCharacters

final class StubSaveFavoritedDisneyCharacterService: SaveFavoritedDisneyCharacterServiceProtocol {
    var result: Result<Void, ServiceError>?
    
    func save(_ disneyCharacter: DisneyCharacters.DisneyCharacter) async -> Result<Void, ServiceError> {
        guard let result else { return .failure(.apiError) }
        return result
    }
    
    
}
