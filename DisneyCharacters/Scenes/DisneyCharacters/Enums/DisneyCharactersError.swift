//
//  DisneyCharactersError.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation

enum DisneyCharactersError: Error {
    case fetchCharactersNotFound
    case network
    case generic
}
