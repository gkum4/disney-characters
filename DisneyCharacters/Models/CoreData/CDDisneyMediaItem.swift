//
//  CDDisneyMediaItem+CoreDataClass.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//
//

import Foundation
import CoreData

public class CDDisneyMediaItem: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var watched: Bool
    @NSManaged public var mediaType: Int16
    @NSManaged public var reviewScore: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDisneyMediaItem> {
        return NSFetchRequest<CDDisneyMediaItem>(entityName: "CDDisneyMediaItem")
    }
}

extension CDDisneyMediaItem: Identifiable {}
