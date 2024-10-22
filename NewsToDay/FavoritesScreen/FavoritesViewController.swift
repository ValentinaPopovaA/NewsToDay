//
//  FavoritesViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let favoritesView = FavoritesView()
    private let favoritesManager = FavoritesManager()

    private var favorites: [Article] = []

    override func loadView() {
        self.view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmarks"
        view.backgroundColor = .white
        
        // Тест - удалить
        if favoritesManager.getFavorites().isEmpty {
            let mockArticles = createMockArticles()
            for article in mockArticles {
                favoritesManager.addToFavorites(article)
            }
        }

        setupTableView()
        loadFavorites()
    }
    
    // Тестовый метод - удалить
    func createMockArticles() -> [Article] {
        return [
            Article(title: "A Simple Trick For Creating Color Palettes Quickly", description: "Learn how to create color palettes", author: "UI/UX Design", urlToImage: "https://example.com/image1.jpg", publishedAt: "2024-10-22", category: "Design"),
            Article(title: "Six steps to creating a color palette", description: "Master the steps to make your own palette", author: "Art", urlToImage: "https://example.com/image2.jpg", publishedAt: "2024-10-22", category: "Art"),
//            Article(title: "Creating Color Palette from world around you", description: "Get inspired by nature", author: "Colors", urlToImage: "https://example.com/image3.jpg", publishedAt: "2024-10-22", category: "Colors")
        ]
    }

    private func setupTableView() {
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.delegate = self
        favoritesView.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "BookmarkCell")
        favoritesView.tableView.rowHeight = UITableView.automaticDimension
        favoritesView.tableView.estimatedRowHeight = 150
    }

    private func loadFavorites() {
        favorites = favoritesManager.getFavorites()
        updateView()
    }

    private func updateView() {
        if favorites.isEmpty {
            favoritesView.showEmptyState(true) // Показать пустое состояние, если нет избранных
        } else {
            favoritesView.showEmptyState(false) // Показать таблицу, если есть избранные
        }
        favoritesView.tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        let article = favorites[indexPath.row]
        cell.configure(with: article)
        return cell
    }

    // Удаление статьи из избранного
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let article = favorites[indexPath.row]
            favoritesManager.removeFromFavorites(article)
            loadFavorites()
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Логика для открытия статьи или других действий
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
