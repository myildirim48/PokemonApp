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
                             , font: .systemFont(ofSize: 18,weight: .semibold))
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var imgUrlFromVC : String = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pokemon: PokemonModelResult? {
        didSet {
            guard let pokemon = pokemon else { return }
            nameLabel.text = pokemon.name.capitalizingFirstLetter()
            let newUrl = pokemon.url.toImgurl()
            Task {
                self.imageView.image = await ImageFetcher.shared.downloadImage(from: newUrl)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    //MARK: - Private
    
    private func configure() {
        addSubviews(imageView,nameLabel,activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        let spacing = CGFloat(20)
        let innerSpace = CGFloat(10)
        
        imageView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
        
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
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
