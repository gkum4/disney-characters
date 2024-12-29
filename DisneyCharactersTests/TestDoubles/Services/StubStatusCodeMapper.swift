//
//  StubStatusCodeMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubStatusCodeMapper: HTTPTaskResultMapperProtocol {
    var result: Result<Void, ServiceError>?
    
    func map(taskResult: HTTPTaskResult) -> Result<Void, ServiceError> {
        guard let result else { return .failure(.serverError(statusCode: 404)) }
        return result
    }
}
