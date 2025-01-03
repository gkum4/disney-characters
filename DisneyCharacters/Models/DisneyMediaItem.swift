//
//  DisneyMediaItem.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

struct DisneyMediaItem {
    let name: String
    var watched: Bool
    let mediaType: DisneyMediaItemType
    var reviewScore: DisneyMediaItemReviewScore?
}

enum DisneyMediaItemType: Int {
    case film = 0
    case shortFilm = 1
    case tvShow = 2
}

enum DisneyMediaItemReviewScore: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}
