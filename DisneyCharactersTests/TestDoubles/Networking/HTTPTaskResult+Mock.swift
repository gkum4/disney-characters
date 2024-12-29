//
//  HTTPTaskResult+Mock.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

extension HTTPTaskResult {
    static func successMock() -> Self {
        return HTTPTaskResult(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "http://teste.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )
    }
    
    static func failureMock() -> Self {
        return HTTPTaskResult(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "http://teste.com")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            )!
        )
    }
}
