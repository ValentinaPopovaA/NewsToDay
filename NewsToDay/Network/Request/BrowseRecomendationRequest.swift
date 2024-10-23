//
//  BrowseRecomendationRequest.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

struct BrowseRecomendationRequest: DataRequest {
    private let apiKey: String = "41863cb7688141519c1b55f8305bd23f"
        
    var category: String!
    
    var url: String {
        let baseUrl = "https://newsapi.org/v2"
        let path = "/top-headlines"
        return baseUrl + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "apiKey": apiKey,
            "country": "us",
            "category": category,
            "pageSize": "5"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(category: Category) {
        self.category = category.name
    }
    
    func decode(_ data: Data) throws -> [News]? {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(NewsModel.self, from: data)
        return response.articles
    }
}
