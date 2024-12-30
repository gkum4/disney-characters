//
//  TabBarCoordinator.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import UIKit

protocol TabBarCoordinatorProtocol: CoordinatorProtocol {}

class TabBarCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parentCoordinator: CoordinatorProtocol?
    
    lazy var tabBarController = TabBarController.create(coordinator: self)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        setupTabBarPages()
        navigationController.viewControllers = [tabBarController]
    }
    
    private func setupTabBarPages() {
        let tabBarPages: [TabBarPage] = [.disneyCharacters, .myList]
        
        tabBarController.viewControllers = tabBarPages.map { tabBarPage in
            switch tabBarPage {
            case .disneyCharacters:
                let disneyCharactersNavController = UINavigationController()
                disneyCharactersNavController.tabBarItem = UITabBarItem(
                    title: "Personagens",
                    image: UIImage(systemName: "person.2"),
                    tag: 0
                )
                
                let disneyCharactersCoordinator = DisneyCharactersCoordinator(
                    navigationController: disneyCharactersNavController
                )
                childCoordinators.append(disneyCharactersCoordinator)
                disneyCharactersCoordinator.start()
                
                return disneyCharactersNavController
                
            case .myList:
                // TODO: coordinator
                let disneyCharactersNavController = UINavigationController(
                    rootViewController: UIViewController()
                )
                disneyCharactersNavController.tabBarItem = UITabBarItem(
                    title: "Minha Lista",
                    image: UIImage(systemName: "list.bullet.circle"),
                    tag: 1
                )
                return disneyCharactersNavController
            }
        }
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {}
