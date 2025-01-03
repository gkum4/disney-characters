//
//  CDDeleteDisneyMediaItemService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData

final class CDDeleteDisneyMediaItemService: DeleteDisneyMediaItemServiceProtocol {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func delete(name: String, mediaType: DisneyMediaItemType) async -> Result<Void, ServiceError> {
        let request = CDDisneyMediaItem.fetchRequest()
        request.predicate = NSPredicate(
            format: "name == %@ AND mediaType == %d",
            name,
            mediaType.rawValue
        )
        
        guard let cdDisneyMediaItems = try? context.fetch(request) else {
            return .failure(.apiError)
        }
        
        guard let cdModel = cdDisneyMediaItems.first else {
            return .failure(.notFound)
        }
        
        context.delete(cdModel)
        
        return .success(())
    }
}
