//
//  Server.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation
class Server {
    
    public var baseURL: URL

    
    init(baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!) {
        self.baseURL = baseURL
    }
    
    // MARK: - Pokemon Requests
    
    /// Pokemon Request for Pokemons
    func pokemonRequest() throws -> PokemonRequest<PokemonModel>{
        return PokemonRequest(baseURL, path: .base)
    }
    
    /// Pokemon Detail for Pokemon
    func pokemonDetailRequest(with name:String) throws -> PokemonRequest<PokemonDetails>{
        return PokemonRequest(baseURL, path: .detail(name))
    }
    
}
