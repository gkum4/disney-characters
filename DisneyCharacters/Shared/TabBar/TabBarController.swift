//
//  TabBarController.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import UIKit

class TabBarController: UITabBarController {
    private let tabBarPages: [TabBarPage] = [.disneyCharacters, .myList]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarAppearance()
        setupTabBarPages()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        appearance.stackedLayoutAppearance = {
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.iconColor = UIColor.darkGray
            itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            itemAppearance.selected.iconColor = UIColor.purple
            itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
            return itemAppearance
        }()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTabBarPages() {
        viewControllers = tabBarPages.map { getController(for: $0) }
    }
}

extension TabBarController {
    private func getController(for tabBarPage: TabBarPage) -> UIViewController {
        switch tabBarPage {
        case .disneyCharacters:
            let disneyCharactersNavController = UINavigationController(
                rootViewController: DisneyCharactersViewController.create()
            )
            disneyCharactersNavController.tabBarItem = UITabBarItem(
                title: "Personagens",
                image: UIImage(systemName: "person.2"),
                tag: 0
            )
            return disneyCharactersNavController
            
        case .myList:
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

