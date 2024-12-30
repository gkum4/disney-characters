//
//  DisneyCharactersCoordinator.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import UIKit

protocol DisneyCharactersCoordinatorProtocol: CoordinatorProtocol {
    func goToDisneyCharacterDetails(with model: DisneyCharacter)
}

class DisneyCharactersCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parentCoordinator: CoordinatorProtocol?
    lazy var disneyCharactersVC = DisneyCharactersViewController.create(coordinator: self)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.show(disneyCharactersVC, sender: self)
    }
}

extension DisneyCharactersCoordinator: DisneyCharactersCoordinatorProtocol {
    func goToDisneyCharacterDetails(with model: DisneyCharacter) {
        // TODO
    }
}
