//
//  ViewController.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import UIKit

class PokemonVC: UICollectionViewController {
        
    private let environment: Environment!
    private var viewModel: PokemonVM!
    
    required init?(coder:NSCoder) {
        self.environment = Environment(server: Server())
        super.init(coder: coder)
    }
    
    required init(environemnt: Environment, layout: UICollectionViewLayout) {
        self.environment = environemnt
        super.init(collectionViewLayout: layout)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel = PokemonVM(environment: environment)
        defer { viewModel.requestPokemons() }

        let dataSource = generateDatasource(for: collectionView)
        viewModel.configureDataSource(with: dataSource)
        viewModel.errorHandler = self
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.reuseID)
    }
}
//MARK: -  Datasource
extension PokemonVC {
    private func generateDatasource(for collectionView: UICollectionView) -> PokemonDataSource {
        
        let dataSource = PokemonDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, pokemon) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.reuseID, for: indexPath) as! PokemonCell
            cell.pokemon = pokemon
            return cell
        })
        return dataSource
    }
}


//MARK: -  ErrorHandler
extension PokemonVC: PokemonViewModelErrorHandler {
    func viewModelDidReceiveError(error: UserFriendlyError) {
        presentAlertWithError(message: error) { _ in }
    }
}
