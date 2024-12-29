//
//  DecodeMapper.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

final class DecodeMapper<T: Decodable>: HTTPTaskResultMapperProtocol {
    func map(taskResult: HTTPTaskResult) -> Result<T, ServiceError> {
        guard let decoded = try? JSONDecoder().decode(T.self, from: taskResult.data) else {
            return .failure(.decodeError)
        }
        
        return .success(decoded)
    }
}
