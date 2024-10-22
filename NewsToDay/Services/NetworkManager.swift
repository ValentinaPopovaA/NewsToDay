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
    private let baseUrl = "https://newsapi.org/v2/"
    
    private init() {}
    
    // Публичный метод для получения API ключа
    func getApiKey() -> String {
        return apiKey
    }
    
    // Публичный метод для получения базового URL
    func getBaseUrl() -> String {
        return baseUrl
    }
}
