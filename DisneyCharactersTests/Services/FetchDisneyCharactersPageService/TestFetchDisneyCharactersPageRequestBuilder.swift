//
//  TestFetchDisneyCharactersPageRequestBuilder.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestFetchDisneyCharactersPageRequestBuilder: XCTestCase {
    func test_queryItems_whenKeywordIsNil_shouldNotContainName() {
        // Given
        let sut: FetchDisneyCharactersPageRequestBuilder
        
        // When
        sut = FetchDisneyCharactersPageRequestBuilder(keyword: nil, page: 1, pageSize: 20)
        
        // Then
        XCTAssertFalse(sut.queryItems.contains { $0.name == "name" })
    }
    
    func test_queryItems_whenKeywordIsEmpty_shouldNotContainName() {
        // Given
        let sut: FetchDisneyCharactersPageRequestBuilder
        
        // When
        sut = FetchDisneyCharactersPageRequestBuilder(keyword: "", page: 1, pageSize: 20)
        
        // Then
        XCTAssertFalse(sut.queryItems.contains { $0.name == "name" })
    }
}
