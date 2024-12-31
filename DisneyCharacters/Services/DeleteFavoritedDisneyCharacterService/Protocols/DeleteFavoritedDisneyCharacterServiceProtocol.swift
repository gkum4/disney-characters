//
//  DeleteFavoritedDisneyCharacterServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import Foundation

protocol DeleteFavoritedDisneyCharacterServiceProtocol {
    func delete(by id: Int) async -> Result<Void, ServiceError>
}
