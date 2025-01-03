//
//  UpdateDisneyMediaItemServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol UpdateDisneyMediaItemServiceProtocol {
    func update(_ disneyMediaItem: DisneyMediaItem) async -> Result<Void, ServiceError>
}
