//
//  SearchRequest.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

// Запрос на поиск новостных статей на основе поискового запроса и номера страницы
struct SearchResultRequest {
    let searchText: String
    let page: Int
    private let apiKey = "41863cb7688141519c1b55f8305bd23f"
    private let baseURL = "https://newsapi.org/v2/everything?"

    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        return components?.url
    }
}
