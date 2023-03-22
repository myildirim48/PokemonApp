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
    
    /// CharacterRequest for Characters
    /// - Parameter : Public Characters
    /// - Returns: Authenticated request with matching Character type
    func pokemonRequest() throws -> PokemonRequest<PokemonModel>{
        return PokemonRequest(baseURL, path: .base)
    }
    
}
