//
//  DisneyCharacterDetailsCoordinator.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import UIKit
import SwiftUI

protocol DisneyCharacterDetailsCoordinatorProtocol: CoordinatorProtocol {}

final class DisneyCharacterDetailsCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parentCoordinator: CoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with character: DisneyCharacter) {
        navigationController.show(
            UIHostingController(rootView: DisneyCharacterDetailsView.create(character: character)),
            sender: self
        )
    }
}

extension DisneyCharacterDetailsCoordinator: DisneyCharacterDetailsCoordinatorProtocol {}
