//
//  FavoritesViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let favoritesView = FavoritesView()
    private var favorites: [News] = []

    override func loadView() {
        self.view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupTableView()
        updateView()
        loadMockFavorites()
    }
    
    private func setupTableView() {
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.delegate = self
        favoritesView.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseID)
        favoritesView.tableView.rowHeight = UITableView.automaticDimension
        favoritesView.tableView.estimatedRowHeight = 150
    }

    private func loadMockFavorites() {
        // Моковые данные
        favorites = [
            News(source: Source(id: "1", name: "UI/UX Design"), author: "John Doe", title: "A Simple Trick For Creating Color Palettes Quickly", description: "Learn how to create color palettes", url: "https://example.com/article1", urlToImage: "https://ionicframework.com/docs/img/demos/thumbnail.svg", publishedAt: "2024-10-22", content: "Content of article 1"),
            News(source: Source(id: "2", name: "Art"), author: "Jane Doe", title: "Six Steps to Creating a Color Palette", description: "Master the steps to make your own palette", url: "https://example.com/article2", urlToImage: "https://ionicframework.com/docs/img/demos/thumbnail.svg", publishedAt: "2024-10-21", content: "Content of article 2")
        ]

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        let newsItem = favorites[indexPath.row]
        cell.setupCell(news: newsItem)
        return cell
    }

    // MARK: - UITableViewDelegate

    // Установка отступов вокруг ячейки
    func tableView(_ tableView: UITableView, layoutMarginsForRowAt indexPath: IndexPath) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

    // Высота ячейки с учетом отступов
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews = favorites[indexPath.row]
        // переход на DetailScreen
    }
}
