//
//  DisneyCharactersPageResponse+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

#if DEBUG

import Foundation

extension DisneyCharactersPageResponse {
    static func mock() -> Self {
        return DisneyCharactersPageResponse(
            info: .mock(),
            data: [.mock(), .mock()]
        )
    }
}

#endif
