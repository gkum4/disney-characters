//
//  SaveDisneyMediaItemServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol SaveDisneyMediaItemServiceProtocol {
    func save(_ disneyMediaItem: DisneyMediaItem) async -> Result<Void, ServiceError>
}
