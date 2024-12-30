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
    
    private var filmsSectionView: some View {
        VStack(alignment: .leading) {
            Text("Filmes")
                .font(.title2)
                .fontWeight(.medium)
            
            ForEach(viewModel.character.films, id: \.self) { film in
                DisneyCharacterDetailsMediaButtonItemView(name: film) {
                    // TODO
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    private var shortFilmsSectionView: some View {
        VStack(alignment: .leading) {
            Text("Curtas")
                .font(.title2)
                .fontWeight(.medium)
            
            ForEach(viewModel.character.shortFilms, id: \.self) { shortFilm in
                DisneyCharacterDetailsMediaButtonItemView(name: shortFilm) {
                    // TODO
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    private var tvShowsSectionView: some View {
        VStack(alignment: .leading) {
            Text("Séries")
                .font(.title2)
                .fontWeight(.medium)
            
            ForEach(viewModel.character.tvShows, id: \.self) { tvShow in
                DisneyCharacterDetailsMediaButtonItemView(name: tvShow) {
                    // TODO
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                KFImage(viewModel.character.imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: DisneyCharacterDetailsMetrics.imageHeight)
                
                nameSectionView
                    .padding(.bottom, DisneyCharacterDetailsMetrics.padding)
                
                if !viewModel.character.films.isEmpty {
                    filmsSectionView
                        .padding(.bottom, DisneyCharacterDetailsMetrics.padding)
                }
                
                if !viewModel.character.shortFilms.isEmpty {
                    shortFilmsSectionView
                        .padding(.bottom, DisneyCharacterDetailsMetrics.padding)
                }
                
                if !viewModel.character.tvShows.isEmpty {
                    tvShowsSectionView
                        .padding(.bottom, DisneyCharacterDetailsMetrics.padding)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, GlobalLayoutMetrics.contentPadding)
        }
        .environmentObject(viewModel)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.favoriteCharacter) {
                    Image(systemName: "heart.fill")
                }
                .tint(.purple)
            }
        }
    }
}

extension DisneyCharacterDetailsView {
    static func create(character: DisneyCharacter) -> Self {
        let viewModel = DisneyCharacterDetailsViewModel(character: character)
        return DisneyCharacterDetailsView(viewModel: viewModel)
    }
}

#Preview {
    NavigationStack {
        DisneyCharacterDetailsView.create(character: .mock())
            .navigationBarTitleDisplayMode(.inline)
    }
}
