//
//  StubServiceTaskErrorMapper.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class StubServiceTaskErrorMapper: HTTPTaskErrorMapperProtocol {
    var serviceError: ServiceError?
    
    func map(taskError: HTTPTaskError) -> ServiceError {
        guard let serviceError else { return .apiError }
        return serviceError
    }
}
