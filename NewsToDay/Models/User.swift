//
//  User.swift
//  NewsToDay
//
//  Created by Валентина Попова on 23.10.2024.
//

import Foundation

struct User: Codable {
    let id: String
    let password: String
    let categories: [Category]?
    let region: Web.Region?
}
