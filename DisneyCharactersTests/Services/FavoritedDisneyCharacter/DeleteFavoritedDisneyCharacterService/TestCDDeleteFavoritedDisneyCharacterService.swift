//
//  TestCDDeleteFavoritedDisneyCharacterService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDDeleteFavoritedDisneyCharacterService: XCTestCase {
    var sut: CDDeleteFavoritedDisneyCharacterService!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        sut = CDDeleteFavoritedDisneyCharacterService(context: context)
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        sut = nil
        super.setUp()
    }
}

extension TestCDDeleteFavoritedDisneyCharacterService {
    func test_delete_shouldDeleteInContext() async {
        // Given
        let cdModel = CDFavoritedDisneyCharacter.mock(context: context)
        try! context.save()
        XCTAssertFalse(try! context.fetch(CDFavoritedDisneyCharacter.fetchRequest()).isEmpty)
        
        // When
        let result = await sut.delete(by: Int(cdModel.id))
        
        // Then
        guard case .success = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(try! context.fetch(CDFavoritedDisneyCharacter.fetchRequest()).isEmpty)
    }
}
