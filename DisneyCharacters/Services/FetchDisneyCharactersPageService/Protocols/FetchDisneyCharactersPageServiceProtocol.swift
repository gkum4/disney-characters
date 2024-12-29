//
//  FetchDisneyCharactersPageServiceProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

protocol FetchDisneyCharactersPageServiceProtocol {
    func fetch(keyword: String?, page: Int, pageSize: Int) async -> Result<DisneyCharactersPage, ServiceError>
}
