//
//  DisneyMediaItem.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

struct DisneyMediaItem {
    let name: String
    let watched: Bool
    let mediaType: DisneyMediaItemType
    let reviewScore: DisneyMediaItemReviewScore?
}

enum DisneyMediaItemType {
    case film
    case shortFilm
    case tvShow
}

enum DisneyMediaItemReviewScore: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}
