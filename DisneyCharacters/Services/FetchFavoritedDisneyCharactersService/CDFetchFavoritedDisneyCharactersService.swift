//
//  CoreDataFetchFavoritedDisneyCharactersService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData

final class CDFetchFavoritedDisneyCharactersService: FetchFavoritedDisneyCharactersServiceProtocol {
    let context: NSManagedObjectContext
    let cdFetchFavoriteDisneyCharacterMapper: any CDModelMapperProtocol<CDFavoritedDisneyCharacter, FavoritedDisneyCharacter>
    
    init(
        context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext,
        cdFetchFavoriteDisneyCharacterMapper: any CDModelMapperProtocol<CDFavoritedDisneyCharacter, FavoritedDisneyCharacter> = CDFetchFavoritedDisneyCharacterMapper()
    ) {
        self.context = context
        self.cdFetchFavoriteDisneyCharacterMapper = cdFetchFavoriteDisneyCharacterMapper
    }
    
    func fetch() async -> Result<[FavoritedDisneyCharacter], ServiceError> {
        let request = CDFavoritedDisneyCharacter.fetchRequest()
        
        guard let cdFavoritedDisneyCharacters = try? context.fetch(request) else {
            return .failure(.apiError)
        }
        
        var result: [FavoritedDisneyCharacter] = []
        
        for cdModel in cdFavoritedDisneyCharacters {
            switch cdFetchFavoriteDisneyCharacterMapper.map(cdModel) {
            case .success(let model):
                result.append(model)
            case .failure(let error):
                return .failure(error)
            }
        }
        
        return .success(result)
    }
}
