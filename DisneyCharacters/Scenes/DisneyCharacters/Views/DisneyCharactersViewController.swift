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
    
    private lazy var starBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(handleStarTapped)
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var searchTimer: Timer?
    private var favoritesView: Bool = false
    
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
            await viewModel.fetchCharacters()
            collectionView.reloadData()
            hideScreenLoading()
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
        navigationItem.rightBarButtonItem = starBarButtonItem
        navigationItem.titleView = searchBar
    }
    
    @objc override func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    @objc private func handleStarTapped() {
        // TODO: change to favorites view
        favoritesView.toggle()
        starBarButtonItem.image = UIImage(systemName: favoritesView ? "star.fill" : "star")
    }
}

extension DisneyCharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        
        cell.fill(with: viewModel.characters[indexPath.row])
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
}

extension DisneyCharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self else { return }
            
            Task { @MainActor in
                self.showScreenLoading()
                
                await self.viewModel.fetchCharacters(with: searchText)
                self.searchBar.text = searchText
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
        return DisneyCharactersViewController(
            viewModel: DisneyCharactersViewModel(),
            coordinator: coordinator
        )
    }
}
