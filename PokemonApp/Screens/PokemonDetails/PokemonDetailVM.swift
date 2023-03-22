//
//  PokemonDetailVM.swift
//  PokemonApp
//
//  Created by YILDIRIM on 22.03.2023.
//

import Foundation
protocol PokemonDetailViewModelErrorHandler: NSObject {
    func viewModelDidReceiveError(error: UserFriendlyError)
}

class PokemonDetailVM: NSObject {
    
    let environment: Environment
    
    var detailRequest: PokemonRequest<PokemonDetails>!
    var detailRequestLoader : RequestLoader<PokemonRequest<PokemonDetails>>!
    
    var pokemonDetailsVoid : ((PokemonDetails) -> Void)!
    
    weak var errorHandler: PokemonDetailViewModelErrorHandler?
    
    init(environment: Environment!) {
        self.environment = environment
        super.init()

    }
    
    func requestDetails(name: String) {
        
        detailRequest = try? environment.server.pokemonDetailRequest(with: name)
        detailRequestLoader = RequestLoader(request: detailRequest)
        
        detailRequestLoader.load(data: []) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.pokemonDetailsVoid(success)
                }
            case .failure(let failure):
                guard let handler = self.errorHandler else { return }
                handler.viewModelDidReceiveError(error: .userFriendlyError(failure))
            }
        }
    }
}
