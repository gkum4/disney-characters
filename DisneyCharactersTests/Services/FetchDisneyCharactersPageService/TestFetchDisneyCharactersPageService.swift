//
//  TestFetchDisneyCharactersPageService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestFetchDisneyCharactersPageService: XCTestCase {
    var sut: FetchDisneyCharactersPageService!
    var client: StubHTTPClient!
    var fetchDisneyCharactersPageMapper: StubFetchDisneyCharactersPageMapper!
    var taskErrorMapper: StubServiceTaskErrorMapper!
    
    override func setUp() {
        client = StubHTTPClient()
        fetchDisneyCharactersPageMapper = StubFetchDisneyCharactersPageMapper()
        taskErrorMapper = StubServiceTaskErrorMapper()
        sut = FetchDisneyCharactersPageService(
            client: client,
            fetchDisneyCharacterPageMapper: fetchDisneyCharactersPageMapper,
            taskErrorMapper: taskErrorMapper
        )
        super.setUp()
    }
    
    override func tearDown() {
        client = nil
        fetchDisneyCharactersPageMapper = nil
        taskErrorMapper = nil
        sut = nil
        super.tearDown()
    }
}

extension TestFetchDisneyCharactersPageService {
    func test_fetch_whenSuccess_shouldReturnDisneyCharactersPage() async {
        // Given
        client.result = .success(.successMock())
        let mockCharactersPage = DisneyCharactersPage.mock()
        fetchDisneyCharactersPageMapper.result = .success(mockCharactersPage)
        
        // When
        let result = await sut.fetch(keyword: nil, page: 1, pageSize: 20)
        
        // Then
        guard case .success(let success) = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(success.totalPages == mockCharactersPage.totalPages)
        XCTAssertTrue(success.characters.count == mockCharactersPage.characters.count)
    }
    
    func test_fetch_whenClientFails_shouldReturnError() async {
        // Given
        client.result = .failure(.networkError)
        let mockCharactersPage = DisneyCharactersPage.mock()
        fetchDisneyCharactersPageMapper.result = .success(mockCharactersPage)
        
        // When
        let result = await sut.fetch(keyword: nil, page: 1, pageSize: 20)
        
        // Then
        guard case .failure = result else {
            XCTFail()
            return
        }
    }
}
