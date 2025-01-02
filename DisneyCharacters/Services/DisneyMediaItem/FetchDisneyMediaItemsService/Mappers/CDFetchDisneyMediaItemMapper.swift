//
//  CDFetchDisneyMediaItemMapper.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

final class CDFetchDisneyMediaItemMapper: CDModelMapperProtocol {
    func map(_ cdModel: CDDisneyMediaItem) -> Result<DisneyMediaItem, ServiceError> {
        guard let mediaType = decodeMediaType(from: cdModel.mediaType) else {
            return .failure(.decodeError)
        }
        
        var reviewScore: DisneyMediaItemReviewScore?
        if let stringReviewScore = cdModel.reviewScore {
            guard let decodedReviewScore = decodeReviewScore(from: stringReviewScore) else {
                return .failure(.decodeError)
            }
            reviewScore = decodedReviewScore
        }
        
        return .success(
            DisneyMediaItem(
                name: cdModel.name,
                watched: cdModel.watched,
                mediaType: mediaType,
                reviewScore: reviewScore
            )
        )
    }
    
    private func decodeMediaType(from mediaTypeInt16: Int16) -> DisneyMediaItemType? {
        switch mediaTypeInt16 {
        case 0:
            return .film
        case 1:
            return .shortFilm
        case 2:
            return .tvShow
        default:
            return nil
        }
    }
    
    private func decodeReviewScore(from reviewScore: String) -> DisneyMediaItemReviewScore? {
        guard let intValue = Int(reviewScore) else {
            return nil
        }
        
        return DisneyMediaItemReviewScore(rawValue: intValue)
    }
}
