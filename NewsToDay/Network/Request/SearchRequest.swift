//
//  SearchRequest.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

struct SearchResultRequest: DataRequest {
    private let apiKey = "41863cb7688141519c1b55f8305bd23f"
        
    var searchRequest: String!
    var page = 1
    
    var url: String {
        let baseUrl = "https://newsapi.org/v2"
        let path = "/everything?"
        return baseUrl + path
    }
    
    var queryItems: [String : String] {
        [
            "apiKey": apiKey,
            "page": "\(page)",
            "q": searchRequest
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(searchRequest: String, page: Int) {
        self.searchRequest = searchRequest
        self.page = page
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
