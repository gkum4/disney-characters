//
//  TestCDFetchDisneyMediaItemService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDFetchDisneyMediaItemsService: XCTestCase {
    var sut: CDFetchDisneyMediaItemsService!
    var context: NSManagedObjectContext!
    var cdFetchDisneyMediaItemMapper: CDFetchDisneyMediaItemMapper!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        context.reset()
        cdFetchDisneyMediaItemMapper = CDFetchDisneyMediaItemMapper()
        sut = CDFetchDisneyMediaItemsService(
            context: context,
            cdFetchDisneyMediaItemMapper: cdFetchDisneyMediaItemMapper
        )
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        cdFetchDisneyMediaItemMapper = nil
        sut = nil
        super.tearDown()
    }
}

extension TestCDFetchDisneyMediaItemsService {
    func test_fetch_shouldReturnAllSavedDisneyMediaItems() async {
        // Given
        let mock1 = CDDisneyMediaItem.mock(context: context)
        mock1.name = "1"
        let mock2 = CDDisneyMediaItem.mock(context: context)
        mock2.name = "2"
        let mock3 = CDDisneyMediaItem.mock(context: context)
        mock3.name = "3"
        try! context.save()
        
        // When
        let result = await sut.fetch()
        
        // Then
        guard case .success(let models) = result else {
            XCTFail()
            return
        }

        XCTAssertTrue(models.count == 3)
    }
}
