//
//  TestFetchDisneyCharacterMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
import XCTest
@testable import DisneyCharacters

final class TestFetchDisneyCharacterMapper: XCTestCase {
    var sut: FetchDisneyCharacterMapper!
    var statusCodeMapper: StubStatusCodeMapper!
    var decodeMapper: StubDecodeMapper<DisneyCharacterDetailsResponse>!
    
    override func setUp() {
        statusCodeMapper = StubStatusCodeMapper()
        decodeMapper = StubDecodeMapper<DisneyCharacterDetailsResponse>()
        sut = FetchDisneyCharacterMapper(
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

extension TestFetchDisneyCharacterMapper {
    func test_map_whenSuccess_shouldReturnDomainModel() {
        // Given
        let mockModel = DisneyCharacterDetailsResponse.mock()
        statusCodeMapper.result = .success(())
        decodeMapper.result = .success(mockModel)
        
        // When
        let result = sut.map(taskResult: .successMock())
        
        // Then
        guard case .success(let model) = result else {
            XCTFail()
            return
        }
        XCTAssertTrue(model.id == mockModel.data.id)
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
