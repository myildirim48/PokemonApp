//
//  UIHelper.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import UIKit
struct UICollectionViewLayoutGenerator {
    enum CollectionViewStyle{
        case paginated
        
        var suplementaryViewKindForStyle: String {
            switch self {
            case .paginated:
                return LoaderReusableView.elementKind
            }
        }
        var heightForViewKind: CGFloat {
            switch self {
            case .paginated:
                return CGFloat(60.0)
            }
        }
        
        var alignForViewKind: NSRectAlignment {
            switch self {
            case .paginated:
                return .bottom
            }
        }
        
    }
    enum SectionLayoutKind: Int,CaseIterable {
        case list
        
        func columnCount(for width: CGFloat) -> Int{
            let wideMode = width > 800
            let narrowMode = width < 420
            
            switch self {
            case .list :
                return wideMode ? 3 : narrowMode ? 1 : 2
            }
        }
    }
    
    static func generateLayoutForStyle(_ style: CollectionViewStyle) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex)!
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let itemInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            item.contentInsets = itemInsets
            
            let columns = sectionLayoutKind.columnCount(for: layoutEnvironment.container.effectiveContentSize.width)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(180))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
            
            
                let suplemantaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(style.heightForViewKind))
                let suplemantaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: suplemantaryItemSize, elementKind: style.suplementaryViewKindForStyle, alignment: style.alignForViewKind)
                section.boundarySupplementaryItems = [suplemantaryItem]
        
            
            return section
        }
    }
    
}

enum UIHelper {
    
      static func pokemonCollectionViewLayout() -> UICollectionViewLayout {
          
          let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
              let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
              let item = NSCollectionLayoutItem(layoutSize: itemSize)


              let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1))
              let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
              
              let section = NSCollectionLayoutSection(group: group)
              section.interGroupSpacing = 20
              section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
              
              return section
          }
          
          let config = UICollectionViewCompositionalLayoutConfiguration()
          config.interSectionSpacing = 20
          config.scrollDirection = .vertical
          let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
          
          return layout
      }
    
}
