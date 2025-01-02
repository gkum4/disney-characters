//
//  DisneyCharacter+EmptyState.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

extension DisneyCharacter {
    static func emptyState() -> Self {
        return DisneyCharacter(
            id: 0,
            name: "",
            sourceUrl: nil,
            films: [],
            shortFilms: [],
            tvShows: [],
            imageUrl: nil
        )
    }
}
