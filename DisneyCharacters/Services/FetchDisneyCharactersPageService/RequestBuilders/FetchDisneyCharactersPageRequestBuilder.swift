//
//  FetchDisneyCharactersPageRequestBuilder.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

struct FetchDisneyCharactersPageRequestBuilder: HTTPRequestBuilderProtocol {
    internal let baseUrlString: String = APIBaseURL.disney
    internal let path: String = "/character"
    internal let method: String = "GET"
    internal var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let keyword, !keyword.isEmpty {
            items.append(.init(name: "name", value: keyword))
        }
        
        items.append(contentsOf: [
            .init(name: "page", value: String(page)),
            .init(name: "pageSize", value: String(pageSize))
        ])
        
        return items
    }
    
    private let keyword: String?
    private let page: Int
    private let pageSize: Int
    
    init(keyword: String? = nil, page: Int, pageSize: Int) {
        self.keyword = keyword
        self.page = page
        self.pageSize = pageSize
    }
}
