//
//  CDFavoritedDisneyCharacter+CoreDataClass.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//
//

import Foundation
import CoreData

public class CDFavoritedDisneyCharacter: NSManagedObject, Identifiable {
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var sourceUrl: String?
    @NSManaged public var films: Data
    @NSManaged public var shortFilms: Data
    @NSManaged public var tvShows: Data
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoritedDisneyCharacter> {
        return NSFetchRequest<CDFavoritedDisneyCharacter>(entityName: "CDFavoritedDisneyCharacter")
    }
}
