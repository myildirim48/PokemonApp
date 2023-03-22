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
    private enum State { case ready, loading }

    private var state: State = .ready
    private var request : PokemonRequest<PokemonModel>!
    private var requestLoader : RequestLoader<PokemonRequest<PokemonModel>>!
    private var dataSource : PokemonDataSource?
    
    private let environment: Environment
    
    private var pokemonData: PokemonModel?
    
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
    // MARK: - Pagination
//    private let defaultPageSize = 20
//    private let defaultPrefetchBuffer = 1
//
//    private var requestOffset: Int {
//        guard let co = dataContainer else {
//            return 0
//        }
//        let newOffset = co. + defaultPageSize
//        return newOffset >= co.total ? co.offset : newOffset
//    }
//    private var hasNextPage: Bool {
//        guard let co = dataContainer else {
//            return true
//        }
//        let newOffset = co.offset + defaultPageSize
//        return newOffset >= co.total ? false : true
//    }
    
    //MARK: - Data Source
    func item(for indexPath: IndexPath) -> PokemonModelResult? {
        dataSource?.itemIdentifier(for: indexPath)
    }
    private func appendDataSource(with pokemon: [PokemonModelResult]) {
        guard let dataSource = dataSource else { return }
        defer { state = .ready }

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
    @MainActor func shouldFetchData(index: Int){
        guard let dataSource = dataSource else { return }
        let currentSnapshot = dataSource.snapshot()
        
//        guard currentSnapshot.numberOfItems == (index + defaultPrefetchBuffer) && hasNextPage && state == .ready else { return }
        requestPokemons()
    }
    
    func requestPokemons() {
        guard state == .ready else { return }
        state = .loading
        
        let offsetQuery: [Query] = [.offset("0")]
        
        requestLoader.load(data: []) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let container):
                DispatchQueue.main.async {
                    self.pokemonData = container
                    self.appendDataSource(with: container.results)
                }
            case .failure(let error):
                guard let handler = self.errorHandler else { return }
                handler.viewModelDidReceiveError(error: .userFriendlyError(error))
            }
        }
    }
}
