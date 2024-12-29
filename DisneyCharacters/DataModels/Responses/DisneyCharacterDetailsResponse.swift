//
//  DisneyCharacterDetailsResponse.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

struct DisneyCharacterDetailsResponse: Decodable {
    let data: DisneyCharacterResponse
}

extension DisneyCharacterDetailsResponse {
    func toDomainModel() -> DisneyCharacter {
        return data.toDomainModel()
    }
}
