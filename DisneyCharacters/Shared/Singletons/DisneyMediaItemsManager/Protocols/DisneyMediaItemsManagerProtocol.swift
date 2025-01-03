//
//  DisneyMediaItemsManagerProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol DisneyMediaItemsManagerProtocol {
    var mediaItems: [DisneyMediaItem] { get }
    
    func setup() async -> Result<Void, DisneyMediaItemsManagerError>
    func add(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError>
    func update(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError>
    func delete(name: String, mediaType: DisneyMediaItemType) async -> Result<Void, DisneyMediaItemsManagerError>
}
