//
//  StatusCodeMapper.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

final class StatusCodeMapper: HTTPTaskResultMapperProtocol {
    func map(taskResult: HTTPTaskResult) -> Result<Void, ServiceError> {
        let statusCode = taskResult.response.statusCode
        
        guard (200...299) ~= statusCode else {
            return .failure(.serverError(statusCode: statusCode))
        }
        
        return .success(())
    }
}
