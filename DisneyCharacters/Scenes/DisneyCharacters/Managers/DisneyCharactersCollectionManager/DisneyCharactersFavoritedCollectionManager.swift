//
//  DisneyCharactersFavoritedCollectionManager.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import UIKit

final class DisneyCharactersFavoritedCollectionManager: NSObject {
    private let viewModel: DisneyCharactersViewModel
    private weak var coordinator: DisneyCharactersCoordinatorProtocol?
    
    init(
        viewModel: DisneyCharactersViewModel,
        coordinator: DisneyCharactersCoordinatorProtocol?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
}

extension DisneyCharactersFavoritedCollectionManager: DisneyCharactersCollectionManagerProtocol {
    func fetch() async {
        await viewModel.fetchFavoritedCharacters()
    }
    
    func search(with searchKeyword: String) async {
        viewModel.fetchFavoritedCharacters(with: searchKeyword)
    }
}

extension DisneyCharactersFavoritedCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.favoritedCharactersCount
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DisneyCharacterCollectionViewCell.identifier,
                for: indexPath
            ) as? DisneyCharacterCollectionViewCell
        else {
            return .init()
        }
        
        cell.fill(with: viewModel.favoritedCharacters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterId = viewModel.favoritedCharacters[indexPath.item].id
        coordinator?.goToDisneyCharacterDetails(
            with: DisneyCharacterDetailsNavigationData(
                characterId: characterId,
                isFavoritedCharacter: viewModel.isFavoritedCharacter(id: characterId)
            )
        )
    }
}
