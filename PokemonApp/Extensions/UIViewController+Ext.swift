//
//  UIViewController+Ext.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import UIKit
extension UIViewController {
    #warning("")
    func presentAlertWithError(message: UserFriendlyError, callback: @escaping(Bool) -> Void){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: message.title, message: message.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Report", style: .default,handler: { _ in callback(true) }))
            alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: { _ in callback(false) }))
            self.present(alert, animated: true) }
    }
}
