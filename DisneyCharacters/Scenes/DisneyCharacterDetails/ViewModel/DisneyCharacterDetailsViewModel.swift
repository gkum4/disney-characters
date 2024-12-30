//
//  DisneyCharacterDetailsViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

final class DisneyCharacterDetailsViewModel: ObservableObject {
    let character: DisneyCharacter
    
    init(character: DisneyCharacter) {
        self.character = character
    }
    
    func favoriteCharacter() {}
}
