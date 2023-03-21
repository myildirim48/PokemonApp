//
//  Pokemon.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation

struct PokemonModel: Codable,Hashable {
    let count: Int
    let results: [PokemonModelResult]
}

struct PokemonModelResult: Codable,Hashable {
    let name: String
    let url: String
}
