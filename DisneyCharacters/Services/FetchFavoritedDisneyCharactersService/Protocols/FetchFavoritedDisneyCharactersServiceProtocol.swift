//
//  FetchFavoritedDisneyCharactersServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import Foundation

protocol FetchFavoritedDisneyCharactersServiceProtocol {
    func fetch() async -> Result<[DisneyCharacter], ServiceError>
}
