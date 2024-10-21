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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadRandomNews()
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
        ])
    }
    
    private func loadRandomNews() {
        Task {
            do {
                let articles = try await NetworkManager.shared.fetchTopHeadlines(for: nil)
                if let randomArticle = articles.randomElement() {
                    displayArticle(randomArticle)
                } else {
                    displayError("Не удалось загрузить новости")
                }
            } catch {
                displayError("Ошибка при загрузке: \(error.localizedDescription)")
            }
        }
    }
    
    // Отображение данных статьи
    private func displayArticle(_ article: Article) {
        titleLabel.text = article.title
        authorLabel.text = "Autor: \(article.author ?? "Неизвестно")"
        descriptionLabel.text = article.description
        
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            loadImage(from: imageUrl)
        }
    }
    
    private func loadImage(from url: URL) {
        Task {
            if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    private func displayError(_ message: String) {
        titleLabel.text = message
        authorLabel.text = ""
        descriptionLabel.text = ""
    }
}
