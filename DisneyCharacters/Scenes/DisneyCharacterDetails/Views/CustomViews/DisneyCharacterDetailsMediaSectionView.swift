//
//  DisneyCharacterDetailsMediaSectionView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

struct DisneyCharacterDetailsMediaSectionView: View {
    @EnvironmentObject private var viewModel: DisneyCharacterDetailsViewModel
    @State private var selectedMediaType: DisneyMediaItemType
    
    init(initialSelectedMediaType: DisneyMediaItemType) {
        self._selectedMediaType = State(wrappedValue: initialSelectedMediaType)
    }
    
    @ViewBuilder func getMediaItemsView(
        medias: [String],
        mediaType: DisneyMediaItemType
    ) -> some View {
        ForEach(medias, id: \.self) { media in
            Menu {
                if viewModel.isSavedMediaItem(name: media, mediaItemType: mediaType) {
                    Button("Remover da Minha Lista", systemImage: "plus") {
                        Task {
                            await viewModel.deleteMediaItem(name: media, mediaItemType: mediaType)
                        }
                    }
                } else {
                    Button("Adicionar à Minha Lista", systemImage: "plus") {
                        Task {
                            await viewModel.saveMediaItem(name: media, mediaItemType: mediaType)
                        }
                    }
                }
            } label: {
                DisneyCharacterDetailsMediaMenuLabelView(name: media, mediaType: mediaType)
            }
        }
    }
    
    var body: some View {
        VStack {
            Picker("Selecione o tipo de mídia", selection: $selectedMediaType) {
                ForEach(viewModel.availableMediaTypes, id: \.self) { mediaType in
                    Text(mediaType.getTitle())
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selectedMediaType {
            case .film:
                getMediaItemsView(medias: viewModel.character.films, mediaType: .film)
                
            case .shortFilm:
                getMediaItemsView(medias: viewModel.character.shortFilms, mediaType: .shortFilm)
                
            case .tvShow:
                getMediaItemsView(medias: viewModel.character.tvShows, mediaType: .tvShow)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

//#Preview {
//    DisneyCharacterDetailsMediaSectionView(initialSelectedMediaType: .film)
//        .environmentObject(DisneyCharacterDetailsViewModel(character: .mock()))
//        .padding()
//}
