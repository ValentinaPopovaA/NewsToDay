//
//  FavoritesManager.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import Foundation

// удалить
struct Article: Codable {
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let publishedAt: String?
    let category: String?
}

final class FavoritesManager {
    
    private let favoritesKey = "favorites"
    
    // Сохранить новость в избранное
    func addToFavorites(_ item: Article) {
        var favorites = getFavorites()
        favorites.append(item)
        saveFavorites(favorites)
    }
    
    // Удалить новость из избранного
    func removeFromFavorites(_ item: Article) {
        var favorites = getFavorites()
        favorites.removeAll { $0.title == item.title }
        saveFavorites(favorites)
    }
    
    // Проверить, находится ли новость в избранном
    func isFavorite(_ item: Article) -> Bool {
        return getFavorites().contains(where: { $0.title == item.title })
    }
    
    // Получить все избранные статьи
    func getFavorites() -> [Article] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let favorites = try? JSONDecoder().decode([Article].self, from: data) {
            return favorites
        }
        return []
    }
    
    // Сохранить все избранные статьи
    private func saveFavorites(_ favorites: [Article]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
