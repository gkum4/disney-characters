//
//  CDDeleteFavoritedDisneyCharacterService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData

final class CDDeleteFavoritedDisneyCharacterService: DeleteFavoritedDisneyCharacterServiceProtocol {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func delete(by id: Int) async -> Result<Void, ServiceError> {
        let request = CDFavoritedDisneyCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        guard let cdFavoritedDisneyCharacters = try? context.fetch(request) else {
            return .failure(.apiError)
        }
        
        guard let cdModel = cdFavoritedDisneyCharacters.first else {
            return .failure(.notFound)
        }
        
        context.delete(cdModel)
        
        return .success(())
    }
}
