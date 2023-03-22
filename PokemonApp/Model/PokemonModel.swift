//
//  Pokemon.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int
    let results: [PokemonModelResult]
}

struct PokemonModelResult: Codable{
    let name: String
    let url: String
}
extension PokemonModelResult: Hashable, Equatable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
    
    static func == (lhs: PokemonModelResult, rhs: PokemonModelResult) -> Bool {
        return lhs.url == rhs.url && lhs.name == rhs.name
    }
    
}
