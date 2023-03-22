//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    static let reuseID = "pokemon-cell-identifier"

    let imageView = ImageView(frame: .zero)
    let nameLabel = PokLabel(textAligment: .left
                             , font: .systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pokemon: PokemonModelResult? {
        didSet {
            nameLabel.text = pokemon?.name.capitalizingFirstLetter()
        }
    }
    
    //MARK: - Private
    
    private func configure() {
        addSubviews(imageView,nameLabel)
        
        let spacing = CGFloat(20)
        let innerSpace = CGFloat(10)
        
        NSLayoutConstraint.activate([
        
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: innerSpace),
            imageView.topAnchor.constraint(equalTo: topAnchor,constant: innerSpace),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: innerSpace),
            imageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor,constant: -spacing),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: spacing),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -spacing),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
