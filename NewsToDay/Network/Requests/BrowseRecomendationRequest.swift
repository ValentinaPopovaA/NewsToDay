//
//  BrowseRecomendationRequest.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

// Запрос на получение рекомендуемых заголовков в указанной категории
struct BrowseRecommendationRequest: DataRequest {
    var baseRequest: BaseRequest
    
    init(category: Category) {
        self.baseRequest = BaseRequest(endpoint: "/top-headlines", category: category.name, page: 1, pageSize: 5)
    }
    
    var url: String { baseRequest.url }
    var headers: [String: String] { baseRequest.headers }
    var queryItems: [String: String] { baseRequest.queryItems }
    var method: HTTPMethod { baseRequest.method }
    
    func decode(_ data: Data) throws -> [News]? {
        return try baseRequest.decode(data)
    }
}
