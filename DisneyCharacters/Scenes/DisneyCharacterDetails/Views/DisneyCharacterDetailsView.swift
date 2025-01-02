//
//  DisneyCharacterDetailsView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI
import Kingfisher

struct DisneyCharacterDetailsView: View {
    @StateObject private var viewModel: DisneyCharacterDetailsViewModel
    
    private init(viewModel: DisneyCharacterDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var nameSectionView: some View {
        VStack {
            Text(viewModel.character.name)
                .font(.title)
                .fontWeight(.bold)
            
            if let sourceUrl = viewModel.character.sourceUrl {
                Link(destination: sourceUrl) {
                    Text("Saber mais sobre")
                        .font(.subheadline)
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let imageUrl = viewModel.character.imageUrl {
                    KFImage(imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DisneyCharacterDetailsMetrics.imageHeight)
                }
                
                nameSectionView
                    .padding(.bottom, DisneyCharacterDetailsMetrics.padding)
                
                if let initialSelectedMediaType = viewModel.availableMediaTypes.first {
                    DisneyCharacterDetailsMediaSectionView(
                        initialSelectedMediaType: initialSelectedMediaType
                    )
                    .padding(.bottom, DisneyCharacterDetailsMetrics.padding)
                }
            }
            .padding(.horizontal, GlobalLayoutMetrics.contentPadding)
        }
        .environmentObject(viewModel)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        switch viewModel.isFavorited {
                        case true:
                            await viewModel.unfavoriteCharacter()
                        case false:
                            await viewModel.favoriteCharacter()
                        }
                    }
                } label: {
                    Image(systemName: viewModel.isFavorited ? "heart.fill" : "heart")
                }
                .tint(.purple)
            }
        }
        .loaderOverlay(isLoading: viewModel.isLoading)
        .toast($viewModel.toastMessage)
        .task {
            await viewModel.fetchCharacter()
        }
    }
}

extension DisneyCharacterDetailsView {
    static func create(with navigationData: DisneyCharacterDetailsNavigationData) -> Self {
        let viewModel = DisneyCharacterDetailsViewModel(navigationData: navigationData)
        return DisneyCharacterDetailsView(viewModel: viewModel)
    }
}

//#Preview {
//    NavigationStack {
//        DisneyCharacterDetailsView.create(characterId: <#T##Int#>)
//            .navigationBarTitleDisplayMode(.inline)
//    }
//}
