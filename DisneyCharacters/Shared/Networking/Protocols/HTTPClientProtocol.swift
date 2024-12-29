//
//  HTTPClient.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

protocol HTTPClientProtocol {
    func perform(request: URLRequest) async -> Result<HTTPTaskResult, HTTPTaskError>
}
