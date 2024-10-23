//
//  NewsCategory.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import Foundation

struct Category: Equatable, Codable, Hashable {
    let name: String
    let icon: String
}

enum Categories {
    static let business = "business"
    static let entertainment = "entertainment"
    static let general = "general"
    static let health = "health"
    static let science = "science"
    static let sports = "sports"
    static let technology = "technology"
}
