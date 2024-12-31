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
    ) -> Result<FavoritedDisneyCharacter, ServiceError> {
        var imageUrl: URL?
        if let imageUrlString = cdModel.imageUrl {
            imageUrl = URL(string: imageUrlString)
        }
        
        return .success(FavoritedDisneyCharacter(
            id: Int(cdModel.id),
            name: cdModel.name,
            imageUrl: imageUrl
        ))
    }
}
