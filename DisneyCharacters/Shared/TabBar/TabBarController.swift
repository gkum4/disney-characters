//
//  TabBarController.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import UIKit

class TabBarController: UITabBarController {
    private weak var coordinator: TabBarCoordinatorProtocol?
    
    private init(coordinator: TabBarCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarAppearance()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        appearance.stackedLayoutAppearance = {
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.selected.iconColor = UIColor.purple
            itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
            return itemAppearance
        }()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

extension TabBarController {
    static func create(coordinator: TabBarCoordinatorProtocol) -> TabBarController {
        return TabBarController(coordinator: coordinator)
    }
}
