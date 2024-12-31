//
//  FavoritedDisneyCharacter+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import Foundation

extension FavoritedDisneyCharacter {
    static func mock() -> Self {
        return FavoritedDisneyCharacter(
            id: 1,
            name: "Mickey",
            imageUrl: URL(string: "https://static.wikia.nocookie.net/disney/images/9/99/Mickey_Mouse_Disney_3.jpeg")
        )
    }
}
