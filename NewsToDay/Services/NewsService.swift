//
//  NewsService.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
    case serverError(String)
}

class NewsService {
    
    let apiKey = NetworkManager.shared.getApiKey()
    let baseUrl = NetworkManager.shared.getBaseUrl()
    
    // Получение популярных новостей по категориям с обработкой ошибок
    func fetchTopNewsByCategory(category: String, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        let urlString = "\(baseUrl)top-headlines?category=\(category)&apiKey=\(apiKey)&country=us"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(response.articles))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // Поиск новостей по запросу с обработкой ошибок
    func searchNews(query: String, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        let urlString = "\(baseUrl)everything?q=\(query)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(response.articles))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // Получение данных для конкретной статьи с обработкой ошибок
    func fetchArticleDetails(articleId: String, completion: @escaping (Result<Article, NetworkError>) -> Void) {
        let urlString = "\(baseUrl)everything?articleId=\(articleId)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in if let error = error {
            completion(.failure(.serverError(error.localizedDescription)))
            return
        }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let article = try JSONDecoder().decode(Article.self, from: data)
                completion(.success(article))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
