//
//  AuthService.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/30/24.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    private init() {}

    // MARK: - Регистрация нового пользователя
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let authResult = authResult {
                completion(.success(authResult))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать пользователя."])))
            }
        }
    }

    // MARK: - Вход пользователя
    func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let authResult = authResult {
                let userId = authResult.user.uid
                UserDefaults.standard.set(userId, forKey: "userID")
                completion(.success(authResult))
                
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Не удалось выполнить вход."])))
            }
        }
    }

    // MARK: - Выход пользователя
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Проверка состояния авторизации
    func isSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}

