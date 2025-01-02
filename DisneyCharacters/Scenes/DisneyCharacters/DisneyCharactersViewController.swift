//
//  DisneyCharactersViewController.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import UIKit

final class DisneyCharactersViewController: CustomViewController {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .default
        searchBar.placeholder = "Encontre seu personagem Disney"
        searchBar.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: DisneyCharactersMetrics.navigationBarHeight
        )
        return searchBar
    }()
    
    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(handleFavoriteIconTapped)
        )
        barButtonItem.tintColor = .purple
        return barButtonItem
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let size = UIScreen.main.bounds.width/2 - GlobalLayoutMetrics.contentPadding - DisneyCharactersMetrics.spacingBetweenCells
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width/2 - GlobalLayoutMetrics.contentPadding - DisneyCharactersMetrics.spacingBetweenCells,
            height: DisneyCharactersMetrics.Cell.height
        )
        flowLayout.sectionInset = UIEdgeInsets(
            top: GlobalLayoutMetrics.contentPadding,
            left: GlobalLayoutMetrics.contentPadding,
            bottom: GlobalLayoutMetrics.contentPadding,
            right: GlobalLayoutMetrics.contentPadding
        )
        flowLayout.minimumLineSpacing = GlobalLayoutMetrics.contentPadding
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = collectionManager
        collectionView.dataSource = collectionManager
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var selectedCollectionManager: DisneyCharactersCollectionManagerProtocol = collectionManager
    private lazy var collectionManager = DisneyCharactersCollectionManager(
        viewModel: viewModel,
        coordinator: coordinator
    )
    private lazy var favoritedCollectionManager = DisneyCharactersFavoritedCollectionManager(
        viewModel: viewModel,
        coordinator: coordinator
    )
    
    private var searchTask: Task<Void, Never>?
    private var searchTimer: Timer?
    
    private let viewModel: DisneyCharactersViewModel
    private weak var coordinator: DisneyCharactersCoordinatorProtocol?
    
    private init(
        viewModel: DisneyCharactersViewModel,
        coordinator: DisneyCharactersCoordinatorProtocol
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
        setupCollectionView()
        setupNavigationBar()
        setupDismissKeyboardWhenTappedOutside()
        
        Task {
            showScreenLoading()
            
            async let fetchCharacters: () = viewModel.fetchCharacters()
            async let fetchFavoritedCharacters: () = viewModel.fetchFavoritedCharacters()
            _ = await [fetchCharacters, fetchFavoritedCharacters]
            
            collectionView.reloadData()
            hideScreenLoading()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            await viewModel.fetchFavoritedCharacters()
            collectionView.reloadData()
        }
    }
}

extension DisneyCharactersViewController {
    private func setupInterface() {
        view.appendSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(DisneyCharacterCollectionViewCell.self, forCellWithReuseIdentifier: DisneyCharacterCollectionViewCell.identifier)
    }
    
    private func setupNavigationBar() {
        title = "Personagens"
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
        navigationItem.titleView = searchBar
    }
    
    @objc override func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    @objc private func handleFavoriteIconTapped() {
        switch viewModel.displayMode {
        case .characters:
            viewModel.displayMode = .favoritedCharacters
            favoriteBarButtonItem.image = UIImage(systemName: "heart.fill")
            selectedCollectionManager = favoritedCollectionManager
            searchBar.text = viewModel.favoritedCharactersKeyword
            
        case .favoritedCharacters:
            viewModel.displayMode = .characters
            favoriteBarButtonItem.image = UIImage(systemName: "heart")
            selectedCollectionManager = collectionManager
            searchBar.text = viewModel.charactersKeyword
        }
        
        collectionView.delegate = selectedCollectionManager
        collectionView.dataSource = selectedCollectionManager
        collectionView.reloadData()
    }
}

extension DisneyCharactersViewController: DisneyCharactersViewModelDelegate {
    func handleError(_ error: DisneyCharactersError) {
        // TODO: handle errors
    }
}

extension DisneyCharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTask?.cancel()
        
        searchTimer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            
            searchTask = Task { @MainActor in
                self.showScreenLoading()
                
                self.viewModel.clearVariables()
                await self.selectedCollectionManager.search(with: searchText)
                self.collectionView.reloadData()
                
                self.hideScreenLoading()
            }
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 0.3
            self.collectionView.transform = CGAffineTransform.identity.scaledBy(x: 0.99, y: 0.99)
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
            self.collectionView.transform = .identity
        }
        
        endSearchBarEditing()
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endSearchBarEditing()
    }
    
    private func endSearchBarEditing() {
        searchBar.resignFirstResponder()
    }
}

extension DisneyCharactersViewController {
    static func create(
        coordinator: DisneyCharactersCoordinatorProtocol
    ) -> DisneyCharactersViewController {
        let viewModel = DisneyCharactersViewModel()
        let vc = DisneyCharactersViewController(
            viewModel: viewModel,
            coordinator: coordinator
        )
        viewModel.delegate = vc
        
        return vc
    }
}
