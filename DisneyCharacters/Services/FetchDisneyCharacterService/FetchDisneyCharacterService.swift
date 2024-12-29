//
//  FetchDisneyCharacterService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

final class FetchDisneyCharacterService: FetchDisneyCharacterServiceProtocol {
    private let client: HTTPClientProtocol
    private let fetchDisneyCharacterMapper: any HTTPTaskResultMapperProtocol<DisneyCharacter>
    private let taskErrorMapper: any HTTPTaskErrorMapperProtocol<ServiceError>
    
    init(
        client: HTTPClientProtocol = URLSession.shared,
        fetchDisneyCharacterMapper: any HTTPTaskResultMapperProtocol<DisneyCharacter> = FetchDisneyCharacterMapper(),
        taskErrorMapper: any HTTPTaskErrorMapperProtocol<ServiceError> = ServiceTaskErrorMapper()
    ) {
        self.client = client
        self.fetchDisneyCharacterMapper = fetchDisneyCharacterMapper
        self.taskErrorMapper = taskErrorMapper
    }
    
    func fetch(id: Int) async -> Result<DisneyCharacter, ServiceError> {
        guard
            let request = FetchDisneyCharacterRequestBuilder(characterId: id).build()
        else {
            return .failure(.invalidRequest)
        }
        
        let result = await client.perform(request: request)
        
        switch result {
        case .success(let taskResult):
            return fetchDisneyCharacterMapper.map(taskResult: taskResult)
        case .failure(let error):
            return .failure(taskErrorMapper.map(taskError: error))
        }
    }
}
