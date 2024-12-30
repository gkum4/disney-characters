//
//  DisneyCharacterDetailsMediaType.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

enum DisneyCharacterDetailsMediaType: CaseIterable {
    case film
    case shortFilm
    case tvShow
    
    var title: String {
        switch self {
        case .film:
            return "Filmes"
        case .shortFilm:
            return "Curtas"
        case .tvShow:
            return "Séries"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .film:
            return Color(Colors.orange)
        case .shortFilm:
            return Color(Colors.blue)
        case .tvShow:
            return Color(Colors.green)
        }
    }
}
