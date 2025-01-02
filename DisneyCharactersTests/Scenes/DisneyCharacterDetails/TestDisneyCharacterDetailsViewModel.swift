//
//  TestDisneyCharacterDetailsViewModel.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestDisneyCharacterDetailsViewModel: XCTestCase {
    var sut: DisneyCharacterDetailsViewModel!
    var fetchDisneyCharacterService: StubFetchDisneyCharacterService!
    var saveFavoritedDisneyCharacterService: StubSaveFavoritedDisneyCharacterService!
    var deleteFavoritedDisneyCharacterService: StubDeleteFavoritedDisneyCharacterService!
    
    @MainActor
    override func setUp() {
        fetchDisneyCharacterService = StubFetchDisneyCharacterService()
        saveFavoritedDisneyCharacterService = StubSaveFavoritedDisneyCharacterService()
        deleteFavoritedDisneyCharacterService = StubDeleteFavoritedDisneyCharacterService()
        sut = DisneyCharacterDetailsViewModel(
            navigationData: DisneyCharacterDetailsNavigationData(
                characterId: 1,
                isFavoritedCharacter: false
            ),
            fetchDisneyCharacterService: fetchDisneyCharacterService,
            saveFavoritedDisneyCharacterService: saveFavoritedDisneyCharacterService,
            deleteFavoritedDisneyCharacterService: deleteFavoritedDisneyCharacterService
        )
        super.setUp()
    }
    
    override func tearDown() {
        fetchDisneyCharacterService = nil
        saveFavoritedDisneyCharacterService = nil
        deleteFavoritedDisneyCharacterService = nil
        sut = nil
        super.tearDown()
    }
}

extension TestDisneyCharacterDetailsViewModel {
    @MainActor
    func test_fetchCharacter_whenSuccess_shouldPopulateCharacter() async {
        // Given
        let mockModel = DisneyCharacter.mock()
        fetchDisneyCharacterService.result = .success(mockModel)
        
        // When
        await sut.fetchCharacter()
        
        // Then
        XCTAssertTrue(sut.character.name == mockModel.name)
    }
    
    @MainActor
    func test_fetchCharacter_whenFailure_shouldPopulateError() async {
        // Given
        sut.error = nil
        fetchDisneyCharacterService.result = .failure(.notFound)
        
        // When
        await sut.fetchCharacter()
        
        // Then
        XCTAssertNotNil(sut.error)
    }
    
    @MainActor
    func test_favoriteCharacter_whenSuccess_shouldChangeVariables() async {
        // Given
        sut.isFavorited = false
        sut.toastMessage = nil
        saveFavoritedDisneyCharacterService.result = .success(())
        
        // When
        await sut.favoriteCharacter()
        
        // Then
        XCTAssertTrue(sut.isFavorited)
        XCTAssertNotNil(sut.toastMessage)
    }
    
    @MainActor
    func test_unfavoriteCharacter_whenSuccess_shouldChangeVariables() async {
        // Given
        sut.isFavorited = true
        sut.toastMessage = nil
        deleteFavoritedDisneyCharacterService.result = .success(())
        
        // When
        await sut.unfavoriteCharacter()
        
        // Then
        XCTAssertFalse(sut.isFavorited)
        XCTAssertNotNil(sut.toastMessage)
    }
}
