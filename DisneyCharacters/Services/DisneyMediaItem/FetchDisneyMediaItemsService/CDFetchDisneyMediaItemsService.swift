//
//  CDFetchDisneyMediaItemsService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData

final class CDFetchDisneyMediaItemsService: FetchDisneyMediaItemsServiceProtocol {
    let context: NSManagedObjectContext
    let cdFetchDisneyMediaItemMapper: any CDModelMapperProtocol<CDDisneyMediaItem, DisneyMediaItem>
    
    init(
        context: NSManagedObjectContext = CDPersistenceController.shared.container.viewContext,
        cdFetchDisneyMediaItemMapper: any CDModelMapperProtocol<CDDisneyMediaItem, DisneyMediaItem> = CDFetchDisneyMediaItemMapper()
    ) {
        self.context = context
        self.cdFetchDisneyMediaItemMapper = cdFetchDisneyMediaItemMapper
    }
    
    func fetch() async -> Result<[DisneyMediaItem], ServiceError> {
        let request = CDDisneyMediaItem.fetchRequest()
        
        guard let cdDisneyMediaItems = try? context.fetch(request) else {
            return .failure(.apiError)
        }
        
        var result: [DisneyMediaItem] = []
        
        for cdModel in cdDisneyMediaItems {
            switch cdFetchDisneyMediaItemMapper.map(cdModel) {
            case .success(let model):
                result.append(model)
            case .failure(let error):
                return .failure(error)
            }
        }
        
        return .success(result)
    }
    
    
}
