//
//  Array+Ext.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation
extension Array where Element == Query {
    func toItems() -> Array<URLQueryItem>? {
        self.isEmpty ? nil : self.map { $0.item() }
    }
}
