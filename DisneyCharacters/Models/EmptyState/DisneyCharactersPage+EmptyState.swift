//
//  DisneyCharactersPage+EmptyState.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

extension DisneyCharactersPage {
    static func emptyState() -> Self {
        return DisneyCharactersPage(
            totalPages: 0,
            characters: []
        )
    }
}
