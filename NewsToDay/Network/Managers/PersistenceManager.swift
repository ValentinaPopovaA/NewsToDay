//
//  PersistenceManager.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

// MARK: - Протокол для управления закладками новостей
// Протокол для добавления, удаления и получения закладок новостей
protocol PersistenceManagerProtocol {
    func updateWith(bookmark: News, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void)
    func retreiveNews(completed: @escaping (Result<[News], NewsError>) -> Void)
    func save(bookmarks: [News]) -> NewsError?
}

// MARK: - Тип действия для управления закладками
// Определение типа действия для добавления или удаления
enum PersistenceActionType { case add, remove }

// MARK: - Менеджер закладок
// Класс для управления закладками новостей с сохранением в UserDefaults
class PersistenceManager: PersistenceManagerProtocol {
    private let defaults = UserDefaults.standard
    
    static let shared = PersistenceManager()
    
    // MARK: - Добавление или удаление закладки
    // Обновление списка закладок с учетом действия: добавить или удалить
    func updateWith(bookmark: News, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void) {
        retreiveNews { result in
            switch result {
            case .success(var bookmarks):
                
                switch actionType {
                case .add:
                    
                    // Проверка на существование закладки, если уже добавлена
                    guard !bookmarks.contains(bookmark) else {
                        completed(.alreadyBookmarked)
                        return
                    }
                    
                    // Добавление новой закладки
                    bookmarks.append(bookmark)
                    
                case .remove:
                    // Удаление закладки по URL
                    bookmarks.removeAll { $0.url == bookmark.url}
                }
                
                // Сохранение обновленного списка закладок
                completed(self.save(bookmarks: bookmarks))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    // MARK: - Получение всех закладок
    // Возвращает список новостей в закладках или ошибку, если что-то пошло не так
    func retreiveNews(completed: @escaping (Result<[News], NewsError>) -> Void) {
        guard let bookmarksData = defaults.object(forKey: Keys.bookmarks) as? Data else {
            // Если данных нет, возвращает пустой массив
            completed(.success([]))
            return
        }
        
        // Декодирование данных из UserDefaults в массив закладок
        do {
            let decoder = JSONDecoder()
            let bookmarks = try decoder.decode([News].self, from: bookmarksData)
            
            completed(.success(bookmarks))
        } catch {
            completed(.failure(.unableToBookmark))
        }
        
    }
    
    // MARK: - Сохранение закладок
    // Кодирует и сохраняет массив закладок в UserDefaults
    func save(bookmarks: [News]) -> NewsError? {
        do {
            let encoder = JSONEncoder()
            let encodedBookmarks = try encoder.encode(bookmarks)
            
            // Сохранение данных в UserDefaults
            defaults.set(encodedBookmarks, forKey: Keys.bookmarks)
            return nil
        } catch {
            return .unableToBookmark
        }
    }
}
