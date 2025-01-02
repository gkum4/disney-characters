//
//  TestDisneyCharactersViewModel.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import XCTest
@testable import DisneyCharacters

final class TestDisneyCharactersViewModel: XCTestCase {
    var sut: DisneyCharactersViewModel!
    var fetchCharactersPageService: StubFetchDisneyCharactersPageService!
    var delegate: SpyDisneyCharactersViewModelDelegate!
    
    override func setUp() {
        fetchCharactersPageService = StubFetchDisneyCharactersPageService()
        delegate = SpyDisneyCharactersViewModelDelegate()
        sut = DisneyCharactersViewModel(fetchCharactersPageService: fetchCharactersPageService)
        sut.delegate = delegate
        super.setUp()
    }
    
    override func tearDown() {
        fetchCharactersPageService = nil
        delegate = nil
        sut = nil
        super.tearDown()
    }
}

extension TestDisneyCharactersViewModel {
    func test_fetchCharacters_whenServiceSucceeds_shouldUpdateCharactersAndCount() async {
        // Given
        let mockModel = DisneyCharactersPage.mock()
        fetchCharactersPageService.result = .success(mockModel)
        
        // When
        await sut.fetchCharacters()
        
        // Then
        XCTAssertFalse(sut.characters.isEmpty)
        XCTAssertTrue(sut.charactersCount == mockModel.characters.count)
    }
    
    func test_fetchCharacters_whenServiceSucceeds_shouldIncrementCharactersCount() async {
        // Given
        let fetchTimes = 3
        let mockModel = DisneyCharactersPage.mock()
        fetchCharactersPageService.result = .success(mockModel)
        
        // When
        for _ in 0..<fetchTimes {
            await sut.fetchCharacters()
        }
        
        // Then
        XCTAssertTrue(sut.charactersCount == (mockModel.characters.count * fetchTimes))
    }
    
    func test_fetchCharacters_whenServiceFails_shouldCallDelegate() async {
        // Given
        fetchCharactersPageService.result = .failure(.notFound)
        
        // When
        await sut.fetchCharacters()
        
        // Then
        XCTAssertTrue(delegate.fetchCharactersFailedInvoked)
    }
    
    func test_canFetchNextPage_whenNoAvailablePages_shouldReturnFalse() {
        // Given
        let mockModel = DisneyCharactersPage(totalPages: 0, characters: [])
        fetchCharactersPageService.result = .success(mockModel)
        
        // When
        let result = sut.canFetchNextPage(currentItem: 2)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_fetchCharactersWithSearchKeyword_shouldIncrementCharactersAndCount() async {
        // Given
        let mockModel = DisneyCharactersPage.mock()
        fetchCharactersPageService.result = .success(mockModel)
        var totalExpectedCharacters: Int = 0
        
        for _ in 0..<3 {
            // When
            await sut.fetchCharacters(with: "Teste")
            totalExpectedCharacters += mockModel.characters.count
            
            // Then
            XCTAssertTrue(sut.charactersCount == totalExpectedCharacters)
            XCTAssertTrue(sut.characters.count == totalExpectedCharacters)
        }
    }
}
