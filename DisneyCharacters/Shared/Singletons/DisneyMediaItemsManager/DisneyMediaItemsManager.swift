//
//  DisneyMediaItemsManager.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

final class DisneyMediaItemsManager: DisneyMediaItemsManagerProtocol {
    var mediaItems: [DisneyMediaItem] = []
    
    static let shared: DisneyMediaItemsManager = DisneyMediaItemsManager()
    
    private let fetchDisneyMediaItemsService: FetchDisneyMediaItemsServiceProtocol
    private let saveDisneyMediaItemsService: SaveDisneyMediaItemServiceProtocol
    private let updateDisneyMediaItemsService: UpdateDisneyMediaItemServiceProtocol
    private let deleteDisneyMediaItemsService: DeleteDisneyMediaItemServiceProtocol
    
    private init(
        fetchDisneyMediaItemsService: FetchDisneyMediaItemsServiceProtocol = CDFetchDisneyMediaItemsService(),
        saveDisneyMediaItemsService: SaveDisneyMediaItemServiceProtocol = CDSaveDisneyMediaItemService(),
        updateDisneyMediaItemsService: UpdateDisneyMediaItemServiceProtocol = CDUpdateDisneyMediaItemService(),
        deleteDisneyMediaItemsService: DeleteDisneyMediaItemServiceProtocol = CDDeleteDisneyMediaItemService()
    ) {
        self.fetchDisneyMediaItemsService = fetchDisneyMediaItemsService
        self.saveDisneyMediaItemsService = saveDisneyMediaItemsService
        self.updateDisneyMediaItemsService = updateDisneyMediaItemsService
        self.deleteDisneyMediaItemsService = deleteDisneyMediaItemsService
    }
}

extension DisneyMediaItemsManager {
    func fetch() async -> Result<Void, DisneyMediaItemsManagerError> {
        let result = await fetchDisneyMediaItemsService.fetch()
        switch result {
        case .success(let model):
            mediaItems = model
            return .success(())
        case .failure(let error):
            return .failure(toDomainError(error))
        }
    }
    
    func add(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError> {
        let result = await saveDisneyMediaItemsService.save(mediaItem)
        switch result {
        case .success:
            mediaItems.append(mediaItem)
            return .success(())
        case .failure(let error):
            return .failure(toDomainError(error))
        }
    }
    
    func update(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError> {
        guard
            let index = mediaItems.firstIndex(where: {
                $0.name == mediaItem.name && $0.mediaType == mediaItem.mediaType
            })
        else {
            return .failure(.notFound)
        }
        
        let result = await updateDisneyMediaItemsService.update(mediaItem)
        switch result {
        case .success:
            mediaItems[index] = mediaItem
            return .success(())
        case .failure(let error):
            return .failure(toDomainError(error))
        }
    }
    
    func delete(_ mediaItem: DisneyMediaItem) async -> Result<Void, DisneyMediaItemsManagerError> {
        guard
            let index = mediaItems.firstIndex(where: {
                $0.name == mediaItem.name && $0.mediaType == mediaItem.mediaType
            })
        else {
            return .failure(.notFound)
        }
        
        let result = await updateDisneyMediaItemsService.update(mediaItem)
        switch result {
        case .success:
            mediaItems.remove(at: index)
            return .success(())
        case .failure(let error):
            return .failure(toDomainError(error))
        }
    }
}

extension DisneyMediaItemsManager {
    private func toDomainError(_ error: ServiceError) -> DisneyMediaItemsManagerError {
        switch error {
        case .noInternetConnection:
            return .noInternetConnection
        case .notFound:
            return .notFound
        default:
            return .generic
        }
    }
}
