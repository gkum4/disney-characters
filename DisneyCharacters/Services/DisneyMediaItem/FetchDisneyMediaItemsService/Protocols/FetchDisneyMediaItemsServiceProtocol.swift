//
//  FetchDisneyMediaItemsServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol FetchDisneyMediaItemsServiceProtocol {
    func fetch() async -> Result<[DisneyMediaItem], ServiceError>
}
