//
//  DisneyCharacterDetailsViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

@MainActor
final class DisneyCharacterDetailsViewModel: ObservableObject {
    @Published var character: DisneyCharacter = .emptyState()
    @Published var isLoading: Bool = false
    @Published var error: DisneyCharacterDetailsError?
    @Published var isFavorited: Bool
    @Published var toastMessage: String?
    
    var availableMediaTypes: [DisneyMediaItemType] {
        return DisneyMediaItemType.allCases.filter { mediaType in
            switch mediaType {
            case .film:
                return !character.films.isEmpty
            case .shortFilm:
                return !character.shortFilms.isEmpty
            case .tvShow:
                return !character.tvShows.isEmpty
            }
        }
    }
    
    private let characterId: Int
    
    private let fetchDisneyCharacterService: FetchDisneyCharacterServiceProtocol
    private let saveFavoritedDisneyCharacterService: SaveFavoritedDisneyCharacterServiceProtocol
    private let deleteFavoritedDisneyCharacterService: DeleteFavoritedDisneyCharacterServiceProtocol
    private let disneyMediaItemsManager: DisneyMediaItemsManagerProtocol
    
    init(
        navigationData: DisneyCharacterDetailsNavigationData,
        fetchDisneyCharacterService: FetchDisneyCharacterServiceProtocol = RemoteFetchDisneyCharacterService(),
        saveFavoritedDisneyCharacterService: SaveFavoritedDisneyCharacterServiceProtocol = CDSaveFavoritedDisneyCharacterService(),
        deleteFavoritedDisneyCharacterService: DeleteFavoritedDisneyCharacterServiceProtocol = CDDeleteFavoritedDisneyCharacterService(),
        disneyMediaItemsManager: DisneyMediaItemsManagerProtocol = DisneyMediaItemsManager.shared
    ) {
        self.characterId = navigationData.characterId
        self._isFavorited = Published(wrappedValue: navigationData.isFavoritedCharacter)
        self.fetchDisneyCharacterService = fetchDisneyCharacterService
        self.saveFavoritedDisneyCharacterService = saveFavoritedDisneyCharacterService
        self.deleteFavoritedDisneyCharacterService = deleteFavoritedDisneyCharacterService
        self.disneyMediaItemsManager = disneyMediaItemsManager
    }
}

extension DisneyCharacterDetailsViewModel {
    // MARK: - Fetch
    func fetchCharacter() async {
        isLoading = true
        let result = await fetchDisneyCharacterService.fetch(id: characterId)
        isLoading = false
        
        switch result {
        case .success(let model):
            character = model
        case .failure:
            error = .generic
        }
    }
    
    // MARK: - Favorite Character
    func favoriteCharacter() async {
        isLoading = true
        let result = await saveFavoritedDisneyCharacterService.save(character)
        isLoading = false
        
        switch result {
        case .success:
            isFavorited = true
            toastMessage = "Personagem favoritado!"
        case .failure:
            error = .generic
        }
    }
    
    func unfavoriteCharacter() async {
        isLoading = true
        let result = await deleteFavoritedDisneyCharacterService.delete(by: characterId)
        isLoading = false
        
        switch result {
        case .success:
            isFavorited = false
            toastMessage = "Personagem desfavoritado!"
        case .failure:
            error = .generic
        }
    }
    
    // MARK: - Media Items
    func isSavedMediaItem(name: String, mediaItemType: DisneyMediaItemType) -> Bool {
        return disneyMediaItemsManager.mediaItems.contains {
            return $0.name == name && $0.mediaType == mediaItemType
        }
    }
    
    func saveMediaItem(name: String, mediaItemType: DisneyMediaItemType) async {
        isLoading = true
        let result = await disneyMediaItemsManager.add(
            DisneyMediaItem(
                name: name,
                watched: false,
                mediaType: mediaItemType
            )
        )
        isLoading = false
        
        switch result {
        case .success:
            toastMessage = "Item adicionado à Minha Lista"
        case .failure:
            error = .generic
        }
    }
    
    func deleteMediaItem(name: String, mediaItemType: DisneyMediaItemType) async {
        isLoading = true
        let result = await disneyMediaItemsManager.delete(name: name, mediaType: mediaItemType)
        isLoading = false
        
        switch result {
        case .success:
            toastMessage = "Item removido da Minha Lista"
        case .failure:
            error = .generic
        }
    }
}
