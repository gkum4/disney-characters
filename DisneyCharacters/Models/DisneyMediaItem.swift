//
//  DisneyMediaItem.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation
import SwiftUI

struct DisneyMediaItem {
    let name: String
    var watched: Bool = false
    let mediaType: DisneyMediaItemType
    var reviewScore: DisneyMediaItemReviewScore?
}

enum DisneyMediaItemType: Int, CaseIterable {
    case film = 0
    case shortFilm = 1
    case tvShow = 2
    
    func getTitle() -> String {
        switch self {
        case .film:
            return "Filmes"
        case .shortFilm:
            return "Curtas"
        case .tvShow:
            return "Séries"
        }
    }
    
    func getBackgroundColor() -> Color {
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

enum DisneyMediaItemReviewScore: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}
