//
//  RandomNewsViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 21.10.2024.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // Менеджер категорий
    private let categoryManager = CategoryManager()

    // Сервис для работы с сетью
    private let newsService = DefaultNetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAndLoadRandomArticle()
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
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

    // Проверка на наличие выбранных категорий и загрузка случайной новости
    private func checkAndLoadRandomArticle() {
        if categoryManager.selectedCellIndex.isEmpty {
            categoryManager.showAlertNoCategories(vc: self)
        } else {
            // Получаем случайную категорию из выбранных
            let selectedCategoryIndex = categoryManager.selectedCellIndex.randomElement()!
            let selectedCategory = categoryManager.all[selectedCategoryIndex].name
            
            loadRandomArticle(category: selectedCategory)
        }
    }

    // Загрузка случайной статьи по категории
    private func loadRandomArticle(category: String) {
        let request = TopHeadlinesRequest(category: Category(name: category, icon: "📈"), page: 1)

        newsService.request(request) { [weak self] result in
            switch result {
            case .success(let articles):
                if let randomArticle = articles!.randomElement() {
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

    // Отображение статьи на экране
    private func displayArticle(_ article: News) {
        titleLabel.text = article.title
        authorLabel.text = "Автор: \(article.author ?? "Неизвестно")"
        descriptionLabel.text = article.description

        if let imageUrlString = article.urlToImage {
            loadImage(from: imageUrlString)
        }
    }

    // Загрузка изображения по URL с использованием ImageClient
    private func loadImage(from url: String) {
        ImageClient.shared.setImage(from: url, placeholderImage: nil) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

    // Обработка ошибок при загрузке данных
    private func handleError(_ error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
