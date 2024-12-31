//
//  DisneyCharacterResponse.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

struct DisneyCharacterResponse: Decodable {
    let id: Int
    let name: String
    let sourceUrl: String
    let films: [String]
    let shortFilms: [String]
    let tvShows: [String]
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, sourceUrl, films, shortFilms, tvShows, imageUrl
    }
}

extension DisneyCharacterResponse {
    func toDomainModel() -> DisneyCharacter {
        var urlImage: URL?
        if let imageUrl {
            urlImage = URL(string: imageUrl)
        }
        
        return DisneyCharacter(
            id: id,
            name: name,
            sourceUrl: URL(string: sourceUrl),
            films: films,
            shortFilms: shortFilms,
            tvShows: tvShows,
            imageUrl: urlImage
        )
    }
}
