//
//  DisneyMediaItem+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

extension DisneyMediaItem {
    static func mock() -> Self {
        return DisneyMediaItem(
            name: "Movie",
            watched: false,
            mediaType: .film,
            reviewScore: .four
        )
    }
}
