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
    
    var availableMediaTypes: [DisneyCharacterDetailsMediaType] {
        return DisneyCharacterDetailsMediaType.allCases.filter { mediaType in
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
    
    init(
        navigationData: DisneyCharacterDetailsNavigationData,
        fetchDisneyCharacterService: FetchDisneyCharacterServiceProtocol = RemoteFetchDisneyCharacterService(),
        saveFavoritedDisneyCharacterService: SaveFavoritedDisneyCharacterServiceProtocol = CDSaveFavoritedDisneyCharacterService(),
        deleteFavoritedDisneyCharacterService: DeleteFavoritedDisneyCharacterServiceProtocol = CDDeleteFavoritedDisneyCharacterService()
    ) {
        self.characterId = navigationData.characterId
        self._isFavorited = Published(wrappedValue: navigationData.isFavoritedCharacter)
        self.fetchDisneyCharacterService = fetchDisneyCharacterService
        self.saveFavoritedDisneyCharacterService = saveFavoritedDisneyCharacterService
        self.deleteFavoritedDisneyCharacterService = deleteFavoritedDisneyCharacterService
    }
}

extension DisneyCharacterDetailsViewModel {
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
    
    func favoriteCharacter() async {
        isLoading = true
        let result = await saveFavoritedDisneyCharacterService.save(character)
        isLoading = false
        
        switch result {
        case .success(let success):
            isFavorited = true
            toastMessage = "Personagem favoritado!"
        case .failure(let failure):
            error = .generic
        }
    }
    
    func unfavoriteCharacter() async {
        isLoading = true
        let result = await deleteFavoritedDisneyCharacterService.delete(by: characterId)
        isLoading = false
        
        switch result {
        case .success(let success):
            isFavorited = false
            toastMessage = "Personagem desfavoritado!"
        case .failure(let failure):
            error = .generic
        }
    }
}
