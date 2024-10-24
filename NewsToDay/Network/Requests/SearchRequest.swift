//
//  SearchRequest.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

struct SearchResultRequest: DataRequest {
    var baseRequest: BaseRequest
    
    init(searchRequest: String, page: Int) {
        var request = BaseRequest(endpoint: "/everything", category: nil, page: page, pageSize: 10)
        request.additionalQueryItems["q"] = searchRequest
        self.baseRequest = request
    }
    
    var url: String { baseRequest.url }
    var headers: [String: String] { baseRequest.headers }
    var queryItems: [String: String] { baseRequest.queryItems }
    var method: HTTPMethod { baseRequest.method }
    
    func decode(_ data: Data) throws -> [News]? {
        return try baseRequest.decode(data)
    }
}
