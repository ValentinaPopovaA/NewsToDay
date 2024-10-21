//
//  News.swift
//  NewsToDay
//
//  Created by Валентина Попова on 21.10.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let publishedAt: String?
    let category: String?
}
