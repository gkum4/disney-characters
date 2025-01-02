//
//  CDFavoritedDisneyCharacter+Mock.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

#if DEBUG
import CoreData

extension CDFavoritedDisneyCharacter {
    static func mock(context: NSManagedObjectContext) -> CDFavoritedDisneyCharacter {
        let cdModel = CDFavoritedDisneyCharacter(context: context)
        cdModel.id = 1
        cdModel.name = "Mickey"
        cdModel.imageUrl = "https://static.wikia.nocookie.net/disney/images/9/99/Mickey_Mouse_Disney_3.jpeg"
        cdModel.sourceUrl = ""
        cdModel.films = try! JSONEncoder().encode([String]())
        cdModel.shortFilms = try! JSONEncoder().encode([String]())
        cdModel.tvShows = try! JSONEncoder().encode([String]())
        return cdModel
    }
}
#endif
