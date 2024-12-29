//
//  HTTPRequestBuilderProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

protocol HTTPRequestBuilderProtocol {
    var baseUrlString: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension HTTPRequestBuilderProtocol {
    func build() -> URLRequest? {
        guard var components = URLComponents(string: baseUrlString) else { return nil }
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
