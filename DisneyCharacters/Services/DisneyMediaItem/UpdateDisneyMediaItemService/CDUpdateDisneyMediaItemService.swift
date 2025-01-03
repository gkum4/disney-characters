//
//  CDUpdateDisneyMediaItemService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData

final class CDUpdateDisneyMediaItemService: UpdateDisneyMediaItemServiceProtocol {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func update(_ disneyMediaItem: DisneyMediaItem) async -> Result<Void, ServiceError> {
        let request = CDDisneyMediaItem.fetchRequest()
        request.predicate = NSPredicate(
            format: "name == %@ AND mediaType == %d",
            disneyMediaItem.name,
            disneyMediaItem.mediaType.rawValue
        )
        
        guard let cdDisneyMediaItems = try? context.fetch(request) else {
            return .failure(.apiError)
        }
        
        guard let cdModel = cdDisneyMediaItems.first else {
            return .failure(.notFound)
        }
        
        cdModel.name = disneyMediaItem.name
        cdModel.watched = disneyMediaItem.watched
        cdModel.mediaType = Int16(disneyMediaItem.mediaType.rawValue)
        if let reviewScore = disneyMediaItem.reviewScore {
            cdModel.reviewScore = String(reviewScore.rawValue)
        } else {
            cdModel.reviewScore = nil
        }
        
        guard (try? context.save()) != nil else {
            return .failure(.apiError)
        }
        
        return .success(())
    }
}
