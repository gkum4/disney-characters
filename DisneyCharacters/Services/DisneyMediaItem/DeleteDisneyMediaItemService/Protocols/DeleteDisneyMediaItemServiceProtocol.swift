//
//  DeleteDisneyMediaItemServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol DeleteDisneyMediaItemServiceProtocol {
    func delete(_ mediaItem: DisneyMediaItem) async -> Result<Void, ServiceError>
}
