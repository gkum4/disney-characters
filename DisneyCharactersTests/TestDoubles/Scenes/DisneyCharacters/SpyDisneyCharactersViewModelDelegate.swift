//
//  SpyDisneyCharactersViewModelDelegate.swift
//  DisneyCharactersTests
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import Foundation
@testable import DisneyCharacters

final class SpyDisneyCharactersViewModelDelegate: DisneyCharactersViewModelDelegate {
    var fetchCharactersFailedInvoked: Bool = false
    var fetchCharactersFailedError: DisneyCharactersError?
    
    func handleError(_ error: DisneyCharactersError) {
        fetchCharactersFailedInvoked = true
        fetchCharactersFailedError = error
    }
}
