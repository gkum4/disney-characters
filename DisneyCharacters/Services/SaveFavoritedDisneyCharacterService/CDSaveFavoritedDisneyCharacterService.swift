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
    
    func save(_ disneyCharacter: DisneyCharacter) async -> Result<Void, ServiceError> {
        let cdModel = CDFavoritedDisneyCharacter(context: context)
        cdModel.id = Int32(disneyCharacter.id)
        cdModel.name = disneyCharacter.name
        if let imageUrl = disneyCharacter.imageUrl {
            cdModel.imageUrl = imageUrl.absoluteString
        }
        if let sourceUrl = disneyCharacter.sourceUrl {
            cdModel.sourceUrl = sourceUrl.absoluteString
        }
        guard
            let encodedFilms = encode(disneyCharacter.films),
            let encodedShortFilms = encode(disneyCharacter.shortFilms),
            let encodedTvShows = encode(disneyCharacter.tvShows)
        else {
            return .failure(.encodeError)
        }
        cdModel.films = encodedFilms
        cdModel.shortFilms = encodedShortFilms
        cdModel.tvShows = encodedTvShows
        
        guard (try? context.save()) != nil else {
            return .failure(.apiError)
        }
        
        return .success(())
    }
    
    private func encode(_ list: [String]) -> Data? {
        guard let encoded = try? JSONEncoder().encode(list) else { return nil }
        return encoded
    }
}
