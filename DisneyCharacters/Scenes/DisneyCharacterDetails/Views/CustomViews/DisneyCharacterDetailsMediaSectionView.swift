//
//  DisneyCharacterDetailsMediaSectionView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import SwiftUI

struct DisneyCharacterDetailsMediaSectionView: View {
    @EnvironmentObject private var viewModel: DisneyCharacterDetailsViewModel
    @State private var selectedMediaType: DisneyCharacterDetailsMediaType
    
    init(initialSelectedMediaType: DisneyCharacterDetailsMediaType) {
        self._selectedMediaType = State(wrappedValue: initialSelectedMediaType)
    }
    
    @ViewBuilder func getMediaItemsView(
        medias: [String],
        mediaType: DisneyCharacterDetailsMediaType
    ) -> some View {
        ForEach(medias, id: \.self) { media in
            Menu {
                Button("Adicionar à Minha Lista", systemImage: "plus") {
                    print("add")
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
                    Text(mediaType.title)
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
