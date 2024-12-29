//
//  DisneyCharacterDetailsResponse+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

#if DEBUG

import Foundation

extension DisneyCharacterDetailsResponse {
    static func mock() -> Self {
        return DisneyCharacterDetailsResponse(data: .mock())
    }
}

#endif
