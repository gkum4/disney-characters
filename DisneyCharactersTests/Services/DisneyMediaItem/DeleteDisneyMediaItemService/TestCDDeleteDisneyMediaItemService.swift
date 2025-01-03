//
//  TestCDDeleteDisneyMediaItemService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDDeleteDisneyMediaItemService: XCTestCase {
    var sut: CDDeleteDisneyMediaItemService!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        sut = CDDeleteDisneyMediaItemService(context: context)
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        sut = nil
        super.tearDown()
    }
}

extension TestCDDeleteDisneyMediaItemService {
    func test_delete_whenSuccess_shouldRemoveModelPersistence() async {
        // Given
        let mediaType: DisneyMediaItemType = .film
        let reviewScore: DisneyMediaItemReviewScore = .five
        let cdModel = CDDisneyMediaItem.mock(context: context)
        cdModel.mediaType = Int16(mediaType.rawValue)
        cdModel.reviewScore = String(reviewScore.rawValue)
        try! context.save()
        let domainModel = DisneyMediaItem(
            name: cdModel.name,
            watched: cdModel.watched,
            mediaType: mediaType,
            reviewScore: reviewScore
        )
        
        // When
        let result = await sut.delete(domainModel)
        
        // Then
        guard case .success = result else {
            XCTFail()
            return
        }
        XCTAssertTrue((try! context.fetch(CDDisneyMediaItem.fetchRequest())).isEmpty)
    }
}
