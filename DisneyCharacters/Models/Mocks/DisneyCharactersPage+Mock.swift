//
//  DisneyCharactersPage+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

#if DEBUG

import Foundation

extension DisneyCharactersPage {
    static func mock() -> Self {
        return DisneyCharactersPage(
            totalPages: 3,
            characters: [.mock(), .mock()]
        )
    }
}

#endif
