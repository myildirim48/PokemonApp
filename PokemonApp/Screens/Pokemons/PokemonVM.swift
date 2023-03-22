//
//  PokemonVM.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation

protocol PokemonViewModelErrorHandler: NSObject {
    func viewModelDidReceiveError(error: UserFriendlyError)
}

class PokemonVM: NSObject {
    
    private var request : PokemonRequest<PokemonModel>!
    private var requestLoader : RequestLoader<PokemonRequest<PokemonModel>>!
    private var dataSource : PokemonDataSource?
    
    private let environment: Environment
    
    weak var errorHandler: PokemonViewModelErrorHandler?
    
    init(environment: Environment) {
        self.environment = environment
        super.init()
        
        request = try? environment.server.pokemonRequest()
        requestLoader = RequestLoader(request: request)
    }
    
    func configureDataSource(with dataSource: PokemonDataSource){
        self.dataSource = dataSource
        configureDataSource()
    }
    //MARK: - Data Source
    func item(for indexPath: IndexPath) -> PokemonModelResult? {
        dataSource?.itemIdentifier(for: indexPath)
    }
    private func appendDataSource(with pokemon: [PokemonModelResult]) {
        guard let dataSource = dataSource else { return }

        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.appendItems(pokemon, toSection: .main)
        apply(currentSnapshot)
    }

    private func configureDataSource(){
         var initialSnapshot = PokemonSnapshot()
         initialSnapshot.appendSections([.main])
         initialSnapshot.appendItems([],toSection: .main)
         apply(initialSnapshot, animating: false)
     }
    
    private func apply(_ changes: PokemonSnapshot, animating: Bool = true){
            self.dataSource?.apply(changes, animatingDifferences: animating)
    }
    
    //MARK: - Data Fetch
    func requestPokemons() {
        
        let offsetQuery: [Query] = [.limit("1281")]
        
        requestLoader.load(data: offsetQuery) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let container):
                DispatchQueue.main.async {
                    self.appendDataSource(with: container.results)
                }
            case .failure(let error):
                guard let handler = self.errorHandler else { return }
                handler.viewModelDidReceiveError(error: .userFriendlyError(error))
            }
        }
    }
}
