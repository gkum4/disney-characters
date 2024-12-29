//
//  StubDecodeMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubDecodeMapper<T: Decodable>: HTTPTaskResultMapperProtocol {
    var result: Result<T, ServiceError>?
    
    func map(taskResult: HTTPTaskResult) -> Result<T, ServiceError> {
        guard let result else { return .failure(.decodeError) }
        return result
    }
}
