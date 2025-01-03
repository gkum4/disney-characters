//
//  DisneyMediaItemsManagerProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol DisneyMediaItemsManagerProtocol {
    var mediaItems: [DisneyMediaItem] { get }
    
    func fetch() async -> Result<Void, DisneyMediaItemsManagerError>
    func add(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError>
    func update(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError>
    func delete(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError>
}
