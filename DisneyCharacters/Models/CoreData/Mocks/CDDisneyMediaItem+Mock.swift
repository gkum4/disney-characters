//
//  CDDisneyMediaItem+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

#if DEBUG
import CoreData

extension CDDisneyMediaItem {
    static func mock(context: NSManagedObjectContext) -> CDDisneyMediaItem {
        let cdModel = CDDisneyMediaItem(context: context)
        cdModel.name = "Movie"
        cdModel.watched = true
        cdModel.reviewScore = nil
        cdModel.mediaType = 1
        return cdModel
    }
}
#endif
