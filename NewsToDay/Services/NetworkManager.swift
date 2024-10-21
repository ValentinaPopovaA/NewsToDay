//
//  NetworkManager.swift
//  NewsToDay
//
//  Created by Валентина Попова on 21.10.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "41863cb7688141519c1b55f8305bd23f"
    private let baseURL = "https://newsapi.org/v2/"
    
    func fetchTopHeadlines(for category: String? = nil) async throws -> [Article] {
        var urlString = "\(baseURL)top-headlines?country=us&apiKey=\(apiKey)"
        
        if let category = category {
            urlString += "&category=\(category)"
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(NewsResponse.self, from: data)
        return response.articles
    }
}
