//
//  CDFetchFavoritedDisneyCharacterMapper.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import Foundation

final class CDFetchFavoritedDisneyCharacterMapper: CDModelMapperProtocol {
    func map(
        _ cdModel: CDFavoritedDisneyCharacter
    ) -> Result<DisneyCharacter, ServiceError> {
        var imageUrl: URL?
        if let imageUrlString = cdModel.imageUrl {
            imageUrl = URL(string: imageUrlString)
        }
        
        var sourceUrl: URL?
        if let sourceUrlString = cdModel.sourceUrl {
            sourceUrl = URL(string: sourceUrlString)
        }
        
        guard
            let films = decode(cdModel.films),
            let shortFilms = decode(cdModel.shortFilms),
            let tvShows = decode(cdModel.tvShows)
        else {
            return .failure(.decodeError)
        }
        
        return .success(
            DisneyCharacter(
                id: Int(cdModel.id),
                name: cdModel.name,
                sourceUrl: sourceUrl,
                films: films,
                shortFilms: shortFilms,
                tvShows: tvShows,
                imageUrl: imageUrl
            )
        )
    }
    
    private func decode(_ data: Data) -> [String]? {
        guard let model = try? JSONDecoder().decode([String].self, from: data) else { return nil }
        return model
    }
}
