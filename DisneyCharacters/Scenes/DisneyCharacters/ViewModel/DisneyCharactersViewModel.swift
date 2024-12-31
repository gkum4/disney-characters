//
//  DisneyCharactersViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import Foundation

protocol DisneyCharactersViewModelDelegate: AnyObject {
    func fetchCharactersFailed(with error: DisneyCharactersError)
}

class DisneyCharactersViewModel {
    private(set) var characters: [DisneyCharacter] = []
    private(set) var charactersCount = 0
    
    weak var delegate: DisneyCharactersViewModelDelegate?
    
    private var keyword: String?
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    private var isFetchingNextPage: Bool = false
    
    private let pageSize: Int
    private let fetchCharactersPageService: FetchDisneyCharactersPageServiceProtocol
    
    init(
        pageSize: Int = 30,
        fetchCharactersPageService: FetchDisneyCharactersPageServiceProtocol = RemoteFetchDisneyCharactersPageService()
    ) {
        self.pageSize = pageSize
        self.fetchCharactersPageService = fetchCharactersPageService
    }
}

extension DisneyCharactersViewModel {
    // MARK: - Fetch
    func fetchCharacters() async {
        let result = await fetchCharactersPageService.fetch(
            keyword: keyword,
            page: currentPage,
            pageSize: pageSize
        )
        
        switch result {
        case .success(let model):
            characters.append(contentsOf: model.characters)
            charactersCount += model.characters.count
            totalPages = model.totalPages
        case .failure(let error):
            delegate?.fetchCharactersFailed(with: getDomainError(from: error))
        }
    }
    
    // MARK: - Pagination
    func canFetchNextPage(currentItem: Int) -> Bool {
        return !isFetchingNextPage &&
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
        clearVariables()
        keyword = searchKeyword
        
        await fetchCharacters()
    }
}

extension DisneyCharactersViewModel {
    private func getDomainError(from serviceError: ServiceError?) -> DisneyCharactersError {
        switch serviceError {
        case .notFound:
            return .notFound
        case .noInternetConnection:
            return .network
        default:
            return .generic
        }
    }
    
    private func clearVariables() {
        characters = []
        charactersCount = 0
        totalPages = 0
        currentPage = 1
        keyword = nil
    }
}
