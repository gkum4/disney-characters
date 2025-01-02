//
//  TestFetchDisneyCharactersPageMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestFetchDisneyCharactersPageMapper: XCTestCase {
    var sut: FetchDisneyCharactersPageMapper!
    var statusCodeMapper: StubStatusCodeMapper!
    var decodeMapper: StubDecodeMapper<DisneyCharactersPageResponse>!
    
    override func setUp() {
        statusCodeMapper = StubStatusCodeMapper()
        decodeMapper = StubDecodeMapper<DisneyCharactersPageResponse>()
        sut = FetchDisneyCharactersPageMapper(
            statusCodeMapper: statusCodeMapper,
            decodeMapper: decodeMapper
        )
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        statusCodeMapper = nil
        decodeMapper = nil
        super.tearDown()
    }
}

extension TestFetchDisneyCharactersPageMapper {
    func test_map_whenSuccess_shouldReturnDomainModel() {
        // Given
        let mockModel = DisneyCharactersPageResponse.mock()
        statusCodeMapper.result = .success(())
        decodeMapper.result = .success(mockModel)
        
        // When
        let result = sut.map(taskResult: .successMock())
        
        // Then
        guard case .success(let model) = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(model.totalPages == mockModel.info.totalPages)
        XCTAssertTrue(model.characters.count == mockModel.data.count)
    }
    
    func test_map_whenStatusCodeMapperFails_shouldReturnCorrespondingError() {
        // Given
        let returnedError = ServiceError.serverError(statusCode: 404)
        statusCodeMapper.result = .failure(returnedError)
        decodeMapper.result = .success(.mock())
        
        // When
        let result = sut.map(taskResult: .successMock())
        
        // Then
        guard case .failure(let error) = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(error == returnedError)
    }
    
    func test_map_whenDecodeMapperFails_shouldReturnCorrespondingError() {
        // Given
        let returnedError = ServiceError.decodeError
        statusCodeMapper.result = .success(())
        decodeMapper.result = .failure(returnedError)
        
        // When
        let result = sut.map(taskResult: .successMock())
        
        // Then
        guard case .failure(let error) = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(error == returnedError)
    }
}
