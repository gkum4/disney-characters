//
//  TestRemoteFetchDisneyCharacterService.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestRemoteFetchDisneyCharacterService: XCTestCase {
    var sut: RemoteFetchDisneyCharacterService!
    var client: StubHTTPClient!
    var fetchDisneyCharacterMapper: StubFetchDisneyCharacterMapper!
    var taskErrorMapper: StubServiceTaskErrorMapper!
    
    override func setUp() {
        client = StubHTTPClient()
        fetchDisneyCharacterMapper = StubFetchDisneyCharacterMapper()
        taskErrorMapper = StubServiceTaskErrorMapper()
        sut = RemoteFetchDisneyCharacterService(
            client: client,
            fetchDisneyCharacterMapper: fetchDisneyCharacterMapper,
            taskErrorMapper: taskErrorMapper
        )
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        client = nil
        fetchDisneyCharacterMapper = nil
        taskErrorMapper = nil
        super.tearDown()
    }
}

extension TestRemoteFetchDisneyCharacterService {
    func test_fetch_whenSuccess_shouldReturnDisneyCharacter() async {
        // Given
        client.result = .success(.successMock())
        let mockCharacter = DisneyCharacter.mock()
        fetchDisneyCharacterMapper.result = .success(mockCharacter)
        
        // When
        let result = await sut.fetch(id: 1)
        
        // Then
        guard case .success(let model) = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(model.id == mockCharacter.id)
    }
    
    func test_fetch_whenClientFails_shouldReturnError() async {
        // Given
        client.result = .failure(.networkError)
        let mockCharacter = DisneyCharacter.mock()
        fetchDisneyCharacterMapper.result = .success(mockCharacter)
        
        // When
        let result = await sut.fetch(id: 1)
        
        // Then
        guard case .failure = result else {
            XCTFail()
            return
        }
    }
}
