//
//  DisneyCharacter+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

#if DEBUG

import Foundation

extension DisneyCharacter {
    static func mock() -> Self {
        return DisneyCharacter(
            id: 1,
            name: "Mickey",
            sourceUrl: URL(string: "https://disney.fandom.com/wiki/Mickey_Mouse"),
            films: ["Filme1", "Filme2"],
            shortFilms: ["Curta1", "Curta2"],
            tvShows: ["Série1", "Série2"],
            imageUrl: URL(string: "https://static.wikia.nocookie.net/disney/images/9/99/Mickey_Mouse_Disney_3.jpeg")
        )
    }
}

#endif
