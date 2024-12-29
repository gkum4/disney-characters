//
//  TestFetchDisneyCharacterRequestBuilder.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestFetchDisneyCharacterRequestBuilder: XCTestCase {
    func test_path_shouldContainInformedCharacterId() {
        // Given
        var sut: FetchDisneyCharacterRequestBuilder!
        
        for i in 0...10 {
            // When
            sut = FetchDisneyCharacterRequestBuilder(characterId: i)
            
            // Then
            XCTAssertTrue(sut.path.contains("\(i)"))
        }
    }
}
