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
                KFImage(viewModel.character.imageUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(height: DisneyCharacterDetailsMetrics.imageHeight)
                
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
