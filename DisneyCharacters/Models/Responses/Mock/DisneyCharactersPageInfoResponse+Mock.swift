//
//  DisneyCharactersPageInfoResponse+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

#if DEBUG

import Foundation

extension DisneyCharactersPageInfoResponse {
    static func mock() -> Self {
        return DisneyCharactersPageInfoResponse(totalPages: 3)
    }
}

#endif
