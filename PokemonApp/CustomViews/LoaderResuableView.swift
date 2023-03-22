//
//  LoaderResuableView.swift
//  PokemonApp
//
//  Created by YILDIRIM on 22.03.2023.
//

import UIKit
class LoaderReusableView: UICollectionReusableView {
    
    static let elementKind = "loader-reusable-kind"
    static let reuseIdentifier = "loader-reusable-id"
    
    let testLabel = UILabel()
    
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.text = "Loading..."
        
        activityIndicator.startAnimating()
        
        addSubview(containerView)
        containerView.addSubviews(activityIndicator,testLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60.0),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            testLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            testLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor,constant: 10)
        ])
    }
    
}
