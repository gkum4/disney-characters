//
//  SearchBarView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import UIKit

class SearchBarView: UIView {
    let searchBar: UISearchBar
    
    init(searchBar: UISearchBar) {
        self.searchBar = searchBar
        super.init(frame: .zero)
        
        appendSubview(searchBar)
    }
    
    override convenience init(frame: CGRect) {
        self.init(searchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
