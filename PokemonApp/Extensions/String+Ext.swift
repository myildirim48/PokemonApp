//
//  String+Ext.swift
//  PokemonApp
//
//  Created by YILDIRIM on 22.03.2023.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
