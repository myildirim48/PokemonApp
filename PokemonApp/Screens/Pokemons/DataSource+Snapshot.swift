//
//  DataSource+Snapshot.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//


import UIKit


typealias PokemonSnapshot = NSDiffableDataSourceSnapshot<PokemonDataSource.Section, PokemonModelResult>

class PokemonDataSource: UICollectionViewDiffableDataSource<PokemonDataSource.Section, PokemonModelResult> {
    
    enum Section {
        case main
    }
}
