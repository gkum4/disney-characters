//
//  TestCDFetchFavoritedDisneyCharactersService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData
import XCTest
@testable import DisneyCharacters

final class TestCDFetchFavoritedDisneyCharactersService: XCTestCase {
    var sut: CDFetchFavoritedDisneyCharactersService!
    var context: NSManagedObjectContext!
    var cdFetchFavoriteDisneyCharacterMapper: CDFetchFavoritedDisneyCharacterMapper!
    
    override func setUp() {
        context = CDPersistenceController(inMemory: true).container.viewContext
        context.reset()
        cdFetchFavoriteDisneyCharacterMapper = CDFetchFavoritedDisneyCharacterMapper()
        sut = CDFetchFavoritedDisneyCharactersService(
            context: context,
            cdFetchFavoriteDisneyCharacterMapper: cdFetchFavoriteDisneyCharacterMapper
        )
        super.setUp()
    }
    
    override func tearDown() {
        context = nil
        cdFetchFavoriteDisneyCharacterMapper = nil
        sut = nil
        super.tearDown()
    }
}

extension TestCDFetchFavoritedDisneyCharactersService {
    func test_fetch_shouldReturnAllSavedFavoritedCharacters() async {
        // Given
        let mock1 = CDFavoritedDisneyCharacter.mock(context: context)
        mock1.id = 1
        let mock2 = CDFavoritedDisneyCharacter.mock(context: context)
        mock2.id = 2
        let mock3 = CDFavoritedDisneyCharacter.mock(context: context)
        mock3.id = 3
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
