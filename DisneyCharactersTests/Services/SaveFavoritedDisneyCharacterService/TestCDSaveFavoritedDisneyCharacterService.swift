//
//  TestCDSaveFavoritedDisneyCharacterService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDSaveFavoritedDisneyCharacterService: XCTestCase {
    var sut: CDSaveFavoritedDisneyCharacterService!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        sut = CDSaveFavoritedDisneyCharacterService(context: context)
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        sut = nil
        super.setUp()
    }
}

extension TestCDSaveFavoritedDisneyCharacterService {
    func test_save_shouldSaveInContext() async {
        // Given
        let model = DisneyCharacter.mock()
        
        // When
        let result = await sut.save(model)
        
        // Then
        guard case .success = result else {
            XCTFail()
            return
        }
        XCTAssertFalse(try! context.fetch(CDFavoritedDisneyCharacter.fetchRequest()).isEmpty)
    }
}
