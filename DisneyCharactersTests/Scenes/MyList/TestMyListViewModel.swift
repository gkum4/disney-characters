//
//  TestMyListViewModel.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 03/01/25.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestMyListViewModel: XCTestCase {
    var sut: MyListViewModel!
    var disneyMediaItemsManager: SpyDisneyMediaItemsManager!
    
    @MainActor
    override func setUp() {
        disneyMediaItemsManager = SpyDisneyMediaItemsManager()
        sut = MyListViewModel(disneyMediaItemsManager: disneyMediaItemsManager)
        super.setUp()
    }
    
    override func tearDown() {
        disneyMediaItemsManager = nil
        sut = nil
        super.tearDown()
    }
}

extension TestMyListViewModel {
    @MainActor
    func test_setup_shouldPopulateSectionsDataAccordingToAvailableMediaItemTypes() async {
        // Given
        let mediaItemType1: DisneyMediaItemType = .film
        let mediaItemType2: DisneyMediaItemType = .shortFilm
        let mediaItemType3: DisneyMediaItemType = .tvShow
        
        let mock1 = DisneyMediaItem(name: "mock1", mediaType: mediaItemType1)
        let mock2 = DisneyMediaItem(name: "mock2", mediaType: mediaItemType2)
        let mock3 = DisneyMediaItem(name: "mock3", mediaType: mediaItemType3)
        
        disneyMediaItemsManager.mediaItems = [mock1, mock2, mock3]
        disneyMediaItemsManager.setupResult = .success(())
        
        // When
        await sut.setup()
        
        // Then
        XCTAssertTrue(sut.sectionsData.count == 3)
    }
}
