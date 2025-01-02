//
//  DisneyCharactersCollectionManagerProtocol.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import UIKit

protocol DisneyCharactersCollectionManagerProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    func fetch() async
    func search(with searchKeyword: String) async
}
