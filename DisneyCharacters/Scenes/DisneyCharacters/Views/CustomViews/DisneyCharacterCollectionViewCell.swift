//
//  DisneyCharacterCollectionViewCell.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import UIKit
import Kingfisher

final class DisneyCharacterCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: DisneyCharacterCollectionViewCell.self)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = DisneyCharactersMetrics.Cell.padding
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    private func setupInterface() {
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = GlobalLayoutMetrics.cornerRadius
        
        contentView.appendSubview(
            stackView.appendArrangedSubviews([
                imageView,
                nameLabel
            ])
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: DisneyCharactersMetrics.Cell.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: DisneyCharactersMetrics.Cell.imageWidth),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DisneyCharactersMetrics.Cell.padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DisneyCharactersMetrics.Cell.padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DisneyCharactersMetrics.Cell.padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DisneyCharactersMetrics.Cell.padding),
        ])
    }
}

extension DisneyCharacterCollectionViewCell {
    func fill(with disneyCharacter: DisneyCharacter) {
        imageView.kf.setImage(with: disneyCharacter.imageUrl)
        nameLabel.text = disneyCharacter.name
    }
}
