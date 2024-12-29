//
//  HTTPTaskResultMapperProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

protocol HTTPTaskResultMapperProtocol<T> {
    associatedtype T
    
    func map(taskResult: HTTPTaskResult) -> Result<T, ServiceError>
}
