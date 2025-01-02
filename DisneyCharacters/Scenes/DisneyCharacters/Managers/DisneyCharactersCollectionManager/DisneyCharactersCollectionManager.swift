//
//  DisneyCharactersCollectionManager.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import UIKit

final class DisneyCharactersCollectionManager: NSObject {
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

extension DisneyCharactersCollectionManager: DisneyCharactersCollectionManagerProtocol {
    func fetch() async {
        await viewModel.fetchCharacters()
    }
    
    func search(with searchKeyword: String) async {
        await viewModel.fetchCharacters(with: searchKeyword)
    }
}

extension DisneyCharactersCollectionManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.charactersCount
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
        
        cell.fill(with: viewModel.characters[indexPath.item])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard viewModel.canFetchNextPage(currentItem: indexPath.item) else { return }
        
        Task {
            await viewModel.fetchNextPage()
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterId = viewModel.characters[indexPath.item].id
        coordinator?.goToDisneyCharacterDetails(
            with: DisneyCharacterDetailsNavigationData(
                characterId: characterId,
                isFavoritedCharacter: viewModel.isFavoritedCharacter(id: characterId)
            )
        )
    }
}
