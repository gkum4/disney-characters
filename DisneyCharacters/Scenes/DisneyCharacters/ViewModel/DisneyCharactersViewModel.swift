//
//  DisneyCharactersViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

protocol DisneyCharactersViewModelDelegate:
    AnyObject,
    ErrorHandlerDelegate where ErrorType == DisneyCharactersError {}

class DisneyCharactersViewModel {
    var displayMode: DisneyCharactersDisplayMode = .characters
    
    private(set) var characters: [DisneyCharacter] = []
    private(set) var charactersCount: Int = 0
    
    private(set) var favoritedCharacters: [DisneyCharacter] = []
    private(set) var favoritedCharactersCount: Int = 0
    private var fetchedFavoritedCharacters: [DisneyCharacter] = []
    
    weak var delegate: (any DisneyCharactersViewModelDelegate)?
    
    private(set) var charactersKeyword: String?
    private(set) var favoritedCharactersKeyword: String?
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    private var isFetchingNextPage: Bool = false
    
    private let pageSize: Int
    private let fetchCharactersPageService: FetchDisneyCharactersPageServiceProtocol
    private let fetchFavoritedDisneyCharactersService: FetchFavoritedDisneyCharactersServiceProtocol
    
    init(
        pageSize: Int = 30,
        fetchCharactersPageService: FetchDisneyCharactersPageServiceProtocol = RemoteFetchDisneyCharactersPageService(),
        fetchFavoritedDisneyCharactersService: FetchFavoritedDisneyCharactersServiceProtocol = CDFetchFavoritedDisneyCharactersService()
    ) {
        self.pageSize = pageSize
        self.fetchCharactersPageService = fetchCharactersPageService
        self.fetchFavoritedDisneyCharactersService = fetchFavoritedDisneyCharactersService
    }
}

extension DisneyCharactersViewModel {
    // MARK: - Fetch
    func fetchCharacters() async {
        let result = await fetchCharactersPageService.fetch(
            keyword: charactersKeyword,
            page: currentPage,
            pageSize: pageSize
        )
        
        switch result {
        case .success(let model):
            characters.append(contentsOf: model.characters)
            charactersCount += model.characters.count
            totalPages = model.totalPages
        case .failure(let error):
            delegate?.handleError(getDomainError(from: error))
        }
    }
    
    func fetchFavoritedCharacters() async {
        let result = await fetchFavoritedDisneyCharactersService.fetch()
        
        switch result {
        case .success(let model):
            fetchedFavoritedCharacters = model
            favoritedCharacters = model
            favoritedCharactersCount = model.count
        case .failure(let error):
            delegate?.handleError(getDomainError(from: error))
        }
    }
    
    // MARK: - Pagination
    func canFetchNextPage(currentItem: Int) -> Bool {
        return displayMode == .characters &&
            !isFetchingNextPage &&
            currentPage <= totalPages &&
            currentItem >= charactersCount - 4
    }
    
    func fetchNextPage() async {
        currentPage += 1
        
        isFetchingNextPage = true
        await fetchCharacters()
        isFetchingNextPage = false
    }
    
    // MARK: - Keyword Search
    func fetchCharacters(with searchKeyword: String) async {
        charactersKeyword = searchKeyword
        
        await fetchCharacters()
    }
    
    func fetchFavoritedCharacters(with searchKeyword: String) {
        favoritedCharactersKeyword = searchKeyword
        
        favoritedCharacters = fetchedFavoritedCharacters.filter {
            $0.name.lowercased().contains(searchKeyword.lowercased())
        }
        favoritedCharactersCount = favoritedCharacters.count
    }
    
    // MARK: - Search Variables
    func clearVariables() {
        characters = []
        charactersCount = 0
        totalPages = 0
        currentPage = 1
        charactersKeyword = nil
    }
    
    // MARK: - Favorited Character Verification
    func isFavoritedCharacter(id: Int) -> Bool {
        return favoritedCharacters.contains { $0.id == id }
    }
}

extension DisneyCharactersViewModel {
    private func getDomainError(from serviceError: ServiceError?) -> DisneyCharactersError {
        switch serviceError {
        case .notFound:
            return .fetchCharactersNotFound
        case .noInternetConnection:
            return .network
        default:
            return .generic
        }
    }
}
