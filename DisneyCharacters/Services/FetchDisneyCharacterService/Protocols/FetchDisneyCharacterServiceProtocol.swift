//
//  FetchDisneyCharacterServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

protocol FetchDisneyCharacterServiceProtocol {
    func fetch(id: Int) async -> Result<DisneyCharacter, ServiceError>
}
