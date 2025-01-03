//
//  DisneyCharactersCoordinator.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import UIKit

protocol DisneyCharactersCoordinatorProtocol: CoordinatorProtocol {
    func goToDisneyCharacterDetails(with navigationData: DisneyCharacterDetailsNavigationData)
}

class DisneyCharactersCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parentCoordinator: CoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        let disneyCharactersVC = DisneyCharactersViewController.create(coordinator: self)
        
        navigationController.show(disneyCharactersVC, sender: self)
    }
}

extension DisneyCharactersCoordinator: DisneyCharactersCoordinatorProtocol {
    func goToDisneyCharacterDetails(with navigationData: DisneyCharacterDetailsNavigationData) {
        let disneyCharacterDetailsCoordinator = DisneyCharacterDetailsCoordinator(
            navigationController: navigationController
        )
        childCoordinators.append(disneyCharacterDetailsCoordinator)
        disneyCharacterDetailsCoordinator.start(with: navigationData)
    }
}
