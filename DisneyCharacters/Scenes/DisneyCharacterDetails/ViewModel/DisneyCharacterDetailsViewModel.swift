//
//  DisneyCharacterDetailsViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

final class DisneyCharacterDetailsViewModel: ObservableObject {
    let character: DisneyCharacter
    
    lazy var availableMediaTypes: [DisneyCharacterDetailsMediaType] = {
        return DisneyCharacterDetailsMediaType.allCases.filter { mediaType in
            switch mediaType {
            case .film:
                return !character.films.isEmpty
            case .shortFilm:
                return !character.shortFilms.isEmpty
            case .tvShow:
                return !character.tvShows.isEmpty
            }
        }
    }()
    
    init(character: DisneyCharacter) {
        self.character = character
    }
    
    func favoriteCharacter() {}
}
