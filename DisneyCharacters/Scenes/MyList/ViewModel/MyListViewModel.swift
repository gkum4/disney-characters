//
//  MyListViewModel.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

@MainActor
class MyListViewModel: ObservableObject {
    @Published var sectionsData: [MyListSectionData] = []
    @Published var selectedMediaItem: DisneyMediaItem?
    @Published var isLoading: Bool = false
    @Published var error: DisneyCharacterDetailsError?
    @Published var toastMessage: String?
    
    private let disneyMediaItemsManager: DisneyMediaItemsManagerProtocol
    
    init(
        disneyMediaItemsManager: DisneyMediaItemsManagerProtocol = DisneyMediaItemsManager.shared
    ) {
        self.disneyMediaItemsManager = disneyMediaItemsManager
    }
}

extension MyListViewModel {
    func setup() async {
        isLoading = true
        _ = await disneyMediaItemsManager.setup()
        isLoading = false
        
        setupSections()
    }
    
    func markWatched(_ mediaItem: DisneyMediaItem) async {
        var newMediaItem = mediaItem
        newMediaItem.watched.toggle()
        
        if newMediaItem.watched {
            selectedMediaItem = newMediaItem
        } else {
            newMediaItem.reviewScore = nil
        }
        
        isLoading = true
        _ = await disneyMediaItemsManager.update(newMediaItem)
        isLoading = false
        
        setupSections()
        
        
    }
    
    func delete(_ mediaItem: DisneyMediaItem) async {
        isLoading = true
        _ = await disneyMediaItemsManager.delete(
            name: mediaItem.name,
            mediaType: mediaItem.mediaType
        )
        isLoading = false
        
        setupSections()
    }
    
    func setReview(for mediaItem: DisneyMediaItem, of reviewScore: DisneyMediaItemReviewScore) async {
        var newMediaItem = mediaItem
        newMediaItem.reviewScore = reviewScore
        
        isLoading = true
        _ = await disneyMediaItemsManager.update(newMediaItem)
        isLoading = false
        
        setupSections()
    }
}

extension MyListViewModel {
    private func setupSections() {
        var mediaItemTypesDict: [DisneyMediaItemType: [DisneyMediaItem]] = [:]
        disneyMediaItemsManager.mediaItems.forEach { mediaItem in
            guard var mediaItems = mediaItemTypesDict[mediaItem.mediaType] else {
                mediaItemTypesDict[mediaItem.mediaType] = [mediaItem]
                return
            }
            
            mediaItems.append(mediaItem)
            mediaItemTypesDict[mediaItem.mediaType] = mediaItems
        }
        
        let sectionsData: [MyListSectionData] = mediaItemTypesDict.map { mediaItemDictItem in
            return MyListSectionData(
                mediaItemType: mediaItemDictItem.key,
                mediaItems: mediaItemDictItem.value
            )
        }
        
        self.sectionsData = sectionsData.sorted(by: { $0.mediaItemType.rawValue < $1.mediaItemType.rawValue })
    }
}
