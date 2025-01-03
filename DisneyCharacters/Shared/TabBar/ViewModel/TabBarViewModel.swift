//
//  TabBarViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import Foundation

final class TabBarViewModel {
    let disneyMediaItemsManager: DisneyMediaItemsManagerProtocol
    
    init(disneyMediaItemsManager: DisneyMediaItemsManagerProtocol = DisneyMediaItemsManager.shared) {
        self.disneyMediaItemsManager = disneyMediaItemsManager
    }
    
    func setup() async {
        _ = await disneyMediaItemsManager.setup()
    }
}
