//
//  DeleteDisneyMediaItemServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

protocol DeleteDisneyMediaItemServiceProtocol {
    func delete(name: String, mediaType: DisneyMediaItemType) async -> Result<Void, ServiceError>
}
