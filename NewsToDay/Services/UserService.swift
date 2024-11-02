//
//  UserService.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/31/24.
//

import FirebaseAuth
import FirebaseFirestore

class UserService {
    
    static let shared = UserService()
    private init() {}
    
    private let db = Firestore.firestore()
    
    func saveUserProfile(uid: String, email: String, username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userData = [
            "username": username,
            "email": email
        ]
        
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func saveUserData(uid: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(uid).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchUserData(uid: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let data = document.data() {
                    completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Данные пользователя не найдены."])))
                }
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Документ пользователя не существует."])))
            }
        }
    }
}

