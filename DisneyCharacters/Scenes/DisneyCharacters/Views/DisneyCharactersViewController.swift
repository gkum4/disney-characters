//
//  DisneyCharactersViewController.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 28/12/24.
//

import UIKit

final class DisneyCharactersViewController: UIViewController {
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let size = UIScreen.main.bounds.width/2 - GlobalLayoutMetrics.horizontalPadding - DisneyCharactersMetrics.spacingBetweenCells
        let element = UICollectionViewFlowLayout()
        element.itemSize = .init(width: size, height: size)
        return element
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = .default
        searchBar.placeholder = "Encontre seu personagem Disney"
        searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.layer.zPosition = 100
        label.text = "Loading"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewModel: DisneyCharactersViewModel
    
    private init(viewModel: DisneyCharactersViewModel) {
        self.viewModel = viewModel
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
            loadingLabel.isHidden = false
            await viewModel.fetchCharacters()
            collectionView.reloadData()
            loadingLabel.isHidden = true
        }
    }
}

extension DisneyCharactersViewController {
    private func setupInterface() {
        view.addSubview(collectionView)
        view.addSubview(loadingLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(DisneyCharacterCollectionViewCell.self, forCellWithReuseIdentifier: DisneyCharacterCollectionViewCell.identifier)
    }
    
    private func setupNavigationBar() {
        let searchBarView = SearchBarView(searchBar: searchBar)
        searchBarView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarView
    }
    
    @objc override func dismissKeyboard() {
        searchBar.endEditing(true)
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
}

extension DisneyCharactersViewController: UISearchBarDelegate {}

extension DisneyCharactersViewController {
    static func create() -> DisneyCharactersViewController {
        return DisneyCharactersViewController(viewModel: DisneyCharactersViewModel())
    }
}
