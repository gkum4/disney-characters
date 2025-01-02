//
//  FetchDisneyCharacterMapper.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

final class FetchDisneyCharacterMapper: HTTPTaskResultMapperProtocol {
    let statusCodeMapper: any HTTPTaskResultMapperProtocol<Void>
    let decodeMapper: any HTTPTaskResultMapperProtocol<DisneyCharacterDetailsResponse>
    
    init(
        statusCodeMapper: any HTTPTaskResultMapperProtocol<Void> = StatusCodeMapper(),
        decodeMapper: any HTTPTaskResultMapperProtocol<DisneyCharacterDetailsResponse> = DecodeMapper<DisneyCharacterDetailsResponse>()
    ) {
        self.statusCodeMapper = statusCodeMapper
        self.decodeMapper = decodeMapper
    }
    
    func map(taskResult: HTTPTaskResult) -> Result<DisneyCharacter, ServiceError> {
        if case .failure(let error) = statusCodeMapper.map(taskResult: taskResult) {
            return .failure(error)
        }
        
        switch decodeMapper.map(taskResult: taskResult) {
        case .success(let dataModel):
            return .success(dataModel.data.toDomainModel())
        case .failure(let error):
            return .failure(error)
        }
    }
}
