//
//  Query.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation
struct Query:Equatable,Hashable {
    let name: String
    let value: String
}

extension Query {
    func item() -> URLQueryItem {
        URLQueryItem(name: name, value: value)
    }
    
    static func offset(_ value: String) -> Query {
        Query(name: "offset", value: value)
    }
    
    static func limit(_ value: String) -> Query {
        Query(name: "limit", value: value)
    }
    
}
