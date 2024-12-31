//
//  DisneyCharactersPageResponse.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

struct DisneyCharactersPageResponse: Decodable {
    let info: DisneyCharactersPageInfoResponse
    let data: [DisneyCharacterResponse]
}

extension DisneyCharactersPageResponse {
    func toDomainModel() -> DisneyCharactersPage {
        return DisneyCharactersPage(
            totalPages: info.totalPages,
            characters: data.map({ $0.toDomainModel() })
        )
    }
}
