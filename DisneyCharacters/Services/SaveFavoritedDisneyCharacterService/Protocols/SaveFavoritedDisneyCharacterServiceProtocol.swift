//
//  SaveFavoritedDisneyCharacterServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import Foundation

protocol SaveFavoritedDisneyCharacterServiceProtocol {
    func save(_ disneyCharacter: DisneyCharacter) async -> Result<Void, ServiceError>
}
