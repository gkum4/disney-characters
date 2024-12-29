//
//  FetchDisneyCharactersPageService.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

final class FetchDisneyCharactersPageService: FetchDisneyCharactersPageServiceProtocol {
    private let client: HTTPClientProtocol
    private let fetchDisneyCharacterPageMapper: any HTTPTaskResultMapperProtocol<DisneyCharactersPage>
    private let taskErrorMapper: any HTTPTaskErrorMapperProtocol<ServiceError>
    
    init(
        client: HTTPClientProtocol = URLSession.shared,
        fetchDisneyCharacterPageMapper: any HTTPTaskResultMapperProtocol<DisneyCharactersPage> = FetchDisneyCharactersPageMapper(),
        taskErrorMapper: any HTTPTaskErrorMapperProtocol<ServiceError> = ServiceTaskErrorMapper()
    ) {
        self.client = client
        self.fetchDisneyCharacterPageMapper = fetchDisneyCharacterPageMapper
        self.taskErrorMapper = taskErrorMapper
    }
    
    func fetch(keyword: String?, page: Int, pageSize: Int) async -> Result<DisneyCharactersPage, ServiceError> {
        guard
            let request = FetchDisneyCharactersPageRequestBuilder(
                keyword: keyword,
                page: page,
                pageSize: pageSize
            ).build()
        else {
            return .failure(.invalidRequest)
        }
        
        let result = await client.perform(request: request)
        
        switch result {
        case .success(let taskResult):
            return fetchDisneyCharacterPageMapper.map(taskResult: taskResult)
        case .failure(let error):
            return .failure(taskErrorMapper.map(taskError: error))
        }
    }
}
