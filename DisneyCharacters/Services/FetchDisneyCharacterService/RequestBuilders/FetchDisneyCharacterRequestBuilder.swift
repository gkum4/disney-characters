//
//  FetchDisneyCharacterRequestBuilder.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

struct FetchDisneyCharacterRequestBuilder: HTTPRequestBuilderProtocol {
    internal let baseUrlString: String = APIBaseURL.disney
    internal var path: String { "/character/\(characterId)" }
    internal let method: String = "GET"
    internal let queryItems: [URLQueryItem] = []
    
    private let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
    }
}
