//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by YILDIRIM on 22.03.2023.
//

import UIKit
class PokemonDetailVC: UIViewController {
    
    var pokemonName: String?
    private let environment: Environment!
    private var detailVM: PokemonDetailVM!
    let activityIndicator = UIActivityIndicatorView(style: .large)

    private let imageView = ImageView(frame: .zero)
    private let nameLabel = PokLabel(textAligment: .center, font: .systemFont(ofSize: 18,weight: .bold))
    private let abilityLabel = PokLabel(textAligment: .left, font: .systemFont(ofSize: 14,weight: .medium))
    private let weightLabel = PokLabel(textAligment: .left, font: .systemFont(ofSize: 14,weight: .medium))
    private let heightLabel = PokLabel(textAligment: .left, font: .systemFont(ofSize: 14,weight: .medium))
    
    init(environment: Environment!) {
        self.environment = environment
        super.init(nibName: nil, bundle: nil)

        self.detailVM = PokemonDetailVM(environment: environment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDoneButton()
        
        if let name = pokemonName {
            detailVM.requestDetails(name: name)
        }
        detailVM.pokemonDetailsVoid = { data in
            self.updateUI(with: data)
        }
        detailVM.errorHandler = self
    }
    
    private func configureDoneButton(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func updateUI(with pokemon: PokemonDetails){
        
        
        nameLabel.text = pokemon.name.capitalizingFirstLetter()
        let abilities = pokemon.abilities.map({ $0.ability.name.capitalizingFirstLetter()
        }).joined(separator: ", ")
        abilityLabel.text = "Abilities  :  \(abilities)"
        weightLabel.text = "Weight    :   \(pokemon.weight)"
        heightLabel.text = "Height     :   \(pokemon.height)"
        
        DispatchQueue.main.async {
            Task {
                self.imageView.image = await ImageFetcher.shared.downloadImage(from: pokemon.sprites.other?.home.frontDefault  ?? "")
        self.activityIndicator.stopAnimating()
            }
            
        }
    }
    
    private func configure(){
        view.addSubviews(imageView,nameLabel,abilityLabel,weightLabel,heightLabel,activityIndicator)
        
        view.backgroundColor = .systemBackground
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        let spacing = CGFloat(10)
        let outerSpacing = CGFloat(20)
        
        NSLayoutConstraint.activate([
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: outerSpacing+10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height/3)),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: spacing),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            abilityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: outerSpacing),
            abilityLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: outerSpacing),
            
            weightLabel.leadingAnchor.constraint(equalTo: abilityLabel.leadingAnchor),
            weightLabel.topAnchor.constraint(equalTo: abilityLabel.bottomAnchor,constant: spacing),
            
            heightLabel.leadingAnchor.constraint(equalTo: abilityLabel.leadingAnchor),
            heightLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor,constant: spacing)
        
        ])
    }
}
        
//MARK: -  Error handler

extension PokemonDetailVC: PokemonDetailViewModelErrorHandler {
    func viewModelDidReceiveError(error: UserFriendlyError) {
        presentAlertWithError(message: error) { _ in }
    }
}
