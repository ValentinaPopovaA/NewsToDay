//
//  CategoryManager.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import UIKit

protocol CategoryManagerProtocol {
    var all: [Category] { get }
    var selectedCellIndex: [Int] { get set }
    func showAlertNoCategories(vc: UIViewController)
}

class CategoryManager: CategoryManagerProtocol {
    
    var all: [Category] = [
        Category(name: Categories.general,
                 icon: "⚖️"),
        Category(name: Categories.business,
                 icon: "📈"),
        Category(name: Categories.entertainment,
                 icon: "🎥"),
        Category(name: Categories.health,
                 icon: "🥑"),
        Category(name: Categories.science,
                 icon: "🧬"),
        Category(name: Categories.technology,
                 icon: "📱"),
        Category(name: Categories.sports,
                 icon: "🏈"),
        Category(name: Categories.gaming,
                 icon: "🎮"),
        Category(name: Categories.art,
                 icon: "🎨"),
        Category(name: Categories.life,
                 icon: "🌞"),
        Category(name: Categories.animals,
                 icon: "🐻"),
        Category(name: Categories.food,
                 icon: "🍔"),
        Category(name: Categories.history,
                 icon: "📜"),
        Category(name: Categories.fashion,
                 icon: "👗")
    ]
    
    var selectedCellIndex: [Int] = [0, 1, 2, 3, 4, 5, 6]
    
    // MARK: - Alert func
    func showAlertNoCategories(vc: UIViewController) {
        let alertController = UIAlertController(title: "Внимание", message: "Для отображения новостей выберите хотя бы одну категорию", preferredStyle: .alert)
        
        let alertCancel = UIAlertAction(title: "Хорошо!", style: .cancel) { _ in }
        
        alertController.addAction(alertCancel)
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
