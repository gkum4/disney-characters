//
//  MyListCoordinator.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import UIKit
import SwiftUI

protocol MyListCoordinatorProtocol: CoordinatorProtocol {}

final class MyListCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parentCoordinator: CoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.show(
            UIHostingController(rootView: MyListView.create()),
            sender: self
        )
    }
}

extension MyListCoordinator: MyListCoordinatorProtocol {}
