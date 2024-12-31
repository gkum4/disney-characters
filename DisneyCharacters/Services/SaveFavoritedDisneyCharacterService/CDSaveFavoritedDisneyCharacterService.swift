//
//  CDSaveFavoritedDisneyCharacterService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData

class CDSaveFavoritedDisneyCharacterService: SaveFavoritedDisneyCharacterServiceProtocol {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func save(_ favoritedDisneyCharacter: FavoritedDisneyCharacter) async -> Result<Void, ServiceError> {
        let cdModel = CDFavoritedDisneyCharacter(context: context)
        cdModel.id = Int32(favoritedDisneyCharacter.id)
        cdModel.name = favoritedDisneyCharacter.name
        if let imageUrl = favoritedDisneyCharacter.imageUrl {
            cdModel.imageUrl = imageUrl.absoluteString
        }
        
        guard (try? context.save()) != nil else {
            return .failure(.apiError)
        }
        
        return .success(())
    }
}
