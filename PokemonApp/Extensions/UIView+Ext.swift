//
//  UIView+Ext.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import UIKit
extension UIView{
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
