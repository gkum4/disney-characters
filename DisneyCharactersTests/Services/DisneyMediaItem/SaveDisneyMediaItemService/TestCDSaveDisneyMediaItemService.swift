//
//  TestCDSaveDisneyMediaItemService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDSaveDisneyMediaItemService: XCTestCase {
    var sut: CDSaveDisneyMediaItemService!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        sut = CDSaveDisneyMediaItemService(context: context)
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        sut = nil
        super.tearDown()
    }
}

extension TestCDSaveDisneyMediaItemService {
    func test_save_whenSuccess_shouldPersistModel() async {
        // Given
        let model = DisneyMediaItem.mock()
        
        // When
        let result = await sut.save(model)
        
        // Then
        guard case .success = result else {
            XCTFail()
            return
        }
        XCTAssertTrue((try! context.fetch(CDDisneyMediaItem.fetchRequest())).count == 1)
    }
}
