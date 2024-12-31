//
//  CDModelMapperProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import CoreData

protocol CDModelMapperProtocol<CDType, DomainType> {
    associatedtype CDType: NSManagedObject
    associatedtype DomainType
    
    func map(_ cdModel: CDType) -> Result<DomainType, ServiceError>
}
