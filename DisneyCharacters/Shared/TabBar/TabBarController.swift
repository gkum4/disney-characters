//
//  TabBarController.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import UIKit

class TabBarController: UITabBarController {
    let viewModel: TabBarViewModel
    private weak var coordinator: TabBarCoordinatorProtocol?
    
    private init(viewModel: TabBarViewModel, coordinator: TabBarCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarAppearance()
        
        Task {
            await viewModel.setup()
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
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
        return TabBarController(viewModel: TabBarViewModel(), coordinator: coordinator)
    }
}
