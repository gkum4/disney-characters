//
//  TestCDUpdateDisneyMediaItemService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDUpdateDisneyMediaItemService: XCTestCase {
    var sut: CDUpdateDisneyMediaItemService!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        sut = CDUpdateDisneyMediaItemService(context: context)
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        sut = nil
        super.tearDown()
    }
}

extension TestCDUpdateDisneyMediaItemService {
    func test_update_whenSuccess_shouldUpdatePersistedModel() async {
        // Given
        var model = DisneyMediaItem(
            name: "teste",
            watched: false,
            mediaType: .shortFilm,
            reviewScore: .one
        )
        let cdModel = CDDisneyMediaItem(context: context)
        cdModel.name = model.name
        cdModel.watched = model.watched
        cdModel.mediaType = Int16(model.mediaType.rawValue)
        if let reviewScore = model.reviewScore {
            cdModel.reviewScore = String(reviewScore.rawValue)
        }
        try! context.save()
        
        // When
        model.reviewScore = .five
        let result = await sut.update(model)
        
        // Then
        guard case .success = result else {
            XCTFail()
            return
        }
        let updatedModel = try! context.fetch(CDDisneyMediaItem.fetchRequest()).first!
        XCTAssertTrue(updatedModel.name == model.name)
        XCTAssertTrue(updatedModel.reviewScore == String(model.reviewScore!.rawValue))
    }
}
