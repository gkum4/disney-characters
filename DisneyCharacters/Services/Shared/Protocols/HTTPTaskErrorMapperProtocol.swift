//
//  HTTPTaskErrorMapperProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

protocol HTTPTaskErrorMapperProtocol<T> {
    associatedtype T: Error
    
    func map(taskError: HTTPTaskError) -> T
}
