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
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
}

extension DisneyCharacterCollectionViewCell {
    private func setupInterface() {
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = GlobalLayoutMetrics.cornerRadius
        
        contentView.appendSubview(
            stackView.appendArrangedSubviews([
                imageView,
                labelContainerView.appendSubview(nameLabel)
            ])
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor, constant: DisneyCharactersMetrics.Cell.padding),
            nameLabel.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor, constant: -DisneyCharactersMetrics.Cell.padding),
            nameLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: DisneyCharactersMetrics.Cell.padding),
            nameLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor, constant: -DisneyCharactersMetrics.Cell.padding),
        ])
    }
}

extension DisneyCharacterCollectionViewCell {
    func fill(with disneyCharacter: DisneyCharacter) {
        imageView.kf.setImage(with: disneyCharacter.imageUrl)
        nameLabel.text = disneyCharacter.name
    }
}
