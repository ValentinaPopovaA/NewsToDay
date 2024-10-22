//
//  RandomNewsViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 21.10.2024.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let descriptionLabel = UILabel()

    var selectedCategories = NewsCategory.sports.rawValue

    private let newsService = NewsService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        loadRandomArticle()
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.textColor = .gray
        view.addSubview(authorLabel)

        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        view.addSubview(descriptionLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }

    // Загрузка случайной новости из выбранных категорий
    private func loadRandomArticle() {
        newsService.fetchTopNewsByCategory(category: selectedCategories) { [weak self] result in
            switch result {
            case .success(let articles):
                if let randomArticle = articles.randomElement() {
                    DispatchQueue.main.async {
                        self?.displayArticle(randomArticle)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.handleError(error)
                }
            }
        }
    }

    // Отображение данных статьи
    private func displayArticle(_ article: Article) {
        titleLabel.text = article.title
        authorLabel.text = "Автор: \(article.author ?? "Неизвестно")"
        descriptionLabel.text = article.description
        
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            loadImage(from: imageUrl)
        }
    }

    // Асинхронная загрузка изображения через URLSession
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Ошибка загрузки изображения: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }

    // Обработка ошибок
    private func handleError(_ error: NetworkError) {
        var message = ""
        
        switch error {
        case .badURL:
            message = "Неправильный URL."
        case .noData:
            message = "Нет данных."
        case .decodingError:
            message = "Ошибка при обработке данных."
        case .serverError(let description):
            message = "Ошибка сервера: \(description)"
        }
        
        print("Ошибка: \(message)")
    }
}
