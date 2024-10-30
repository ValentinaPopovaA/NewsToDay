//
//  BaseRequest.swift
//  NewsToDay
//
//  Created by Валентина Попова on 24.10.2024.
//

import Foundation

struct BaseRequest: DataRequest {
    private let apiKey = "41863cb7688141519c1b55f8305bd23f"
    
    var endpoint: String
    var category: String?
    var page: Int
    var pageSize: Int
    var additionalQueryItems: [String: String] = [:]

    var url: String {
        let baseUrl = "https://newsapi.org/v2"
        return baseUrl + endpoint
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var queryItems: [String: String] {
        var items: [String: String] = [
            "apiKey": apiKey,
            "country": "us",
            "pageSize": "\(pageSize)",
            "page": "\(page)"
        ]
        if let category = category {
            items["category"] = category
        }
        additionalQueryItems.forEach { items[$0.key] = $0.value }
        return items
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [News]? {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let response = try decoder.decode(NewsModel.self, from: data)
        return response.articles
    }
}
