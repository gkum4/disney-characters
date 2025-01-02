//
//  StubCDFetchFavoritedDisneyCharacterMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubCDFetchFavoritedDisneyCharacterMapper: CDModelMapperProtocol {
    var result: Result<DisneyCharacter, ServiceError>?
    
    func map(
        _ cdModel: CDFavoritedDisneyCharacter
    ) -> Result<DisneyCharacter, ServiceError> {
        guard let result else { return .failure(.decodeError) }
        return result
    }
}
