//
//  NewsCategory.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

enum NewsCategory: String, CaseIterable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    // Метод для получения всех категорий
    static func allCategories() -> [String] {
        return NewsCategory.allCases.map { $0.rawValue }
    }
}
