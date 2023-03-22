//
//  PokemonDetailVM.swift
//  PokemonApp
//
//  Created by YILDIRIM on 22.03.2023.
//

import Foundation
class PokemonDetailVM: NSObject {
    
    let environment: Environment
    
    var detailRequest: PokemonRequest<PokemonDetails>!
    var detailRequestLoader : RequestLoader<PokemonRequest<PokemonDetails>>!
    
    var pokemonDetailsVoid : ((PokemonDetails) -> Void)! 
    
    init(environment: Environment!) {
        self.environment = environment
        super.init()

    }
    
    func requestDetails(name: String) {
        
        detailRequest = try? environment.server.pokemonDetailRequest(with: name)
        detailRequestLoader = RequestLoader(request: detailRequest)
        
        detailRequestLoader.load(data: []) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.pokemonDetailsVoid(success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
