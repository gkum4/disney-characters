//
//  CDSaveDisneyMediaItemService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData

final class CDSaveDisneyMediaItemService: SaveDisneyMediaItemServiceProtocol {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func save(_ disneyMediaItem: DisneyMediaItem) async -> Result<Void, ServiceError> {
        let cdDisneyMediaItem = CDDisneyMediaItem(context: context)
        cdDisneyMediaItem.name = disneyMediaItem.name
        cdDisneyMediaItem.mediaType = Int16(disneyMediaItem.mediaType.rawValue)
        cdDisneyMediaItem.watched = disneyMediaItem.watched
        if let reviewScore = disneyMediaItem.reviewScore {
            cdDisneyMediaItem.reviewScore = String(reviewScore.rawValue)
        }
        
        guard (try? context.save()) != nil else {
            return .failure(.apiError)
        }
        
        return .success(())
    }
}
