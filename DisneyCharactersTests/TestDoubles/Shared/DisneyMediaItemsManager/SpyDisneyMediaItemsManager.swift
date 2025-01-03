//
//  SpyDisneyMediaItemsManager.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import Foundation
@testable import DisneyCharacters

final class SpyDisneyMediaItemsManager: DisneyMediaItemsManagerProtocol {
    var mediaItems: [DisneyMediaItem] = []
    
    var setupResult: Result<Void, DisneyMediaItemsManagerError>?
    func setup() async -> Result<Void, DisneyMediaItemsManagerError> {
        guard let setupResult else { return .failure(.generic) }
        return setupResult
    }
    
    var addResult: Result<Void, DisneyMediaItemsManagerError>?
    func add(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError> {
        guard let addResult else { return .failure(.generic) }
        return addResult
    }
    
    var updateResult: Result<Void, DisneyMediaItemsManagerError>?
    func update(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError> {
        guard let updateResult else { return .failure(.generic) }
        return updateResult
    }
    
    var deleteResult: Result<Void, DisneyMediaItemsManagerError>?
    func delete(name: String, mediaType: DisneyMediaItemType) async -> Result<Void, DisneyMediaItemsManagerError> {
        guard let deleteResult else { return .failure(.generic) }
        return deleteResult
    }
    
    
}
