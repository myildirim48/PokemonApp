//
//  ImageView.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import UIKit

class ImageView: UIImageView {
    
    let placeHolderImage = UIImage(systemName: "teddybear")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromUrl pokemonID: Int, placeHolderImage:UIImage ) {
        let newUrls = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonID).png"
            Task {
                image = await ImageFetcher.shared.downloadImage(from: newUrls) ?? placeHolderImage
            }
            return
        }
    }
