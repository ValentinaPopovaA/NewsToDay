//
//  NewsDetailViewController.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/22/24.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    var news: News?
    let navigationBarComponent = HeaderView() // Вью с иконкой для возвращения назад, создание закладки и иконкой для шеринга.
    let persistenceManager: PersistenceManagerProtocol = PersistenceManager.shared
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleComponent = TitleView() // Вью для отображения основной информации — тэга, заголовка статьи и подписи автора.
    let titleWithDescriptionView = DescriptionView() // Текстовый блок с заголовком статьи и её описанием.
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        configure()
        
        persistenceManager.retreiveNews { [weak self] result in
            switch result {
            case .success(let bookmarks):
                guard let news = self?.news else { return }
                if bookmarks.contains(where: { $0.url == news.url }) {
                    self?.navigationBarComponent.updateBookmarkIcon(true)
                }
            case .failure(let error):
                break
            }
        }
    }
    
    private func configure() {
        guard let news = news else { return }
        navigationBarComponent.configure(
            backBtn: #selector(backBtnTapped),
            bookMarkIconBtn: #selector(bookMarkIconBtnTapped),
            shareIconBtn: #selector(shareIconBtnTapped),
            target: self
        )
        
        titleComponent.configure(
            tagTitle: news.source.name ?? "",
            tagSelector: #selector(tagBtnTapped),
            titleLabel: news.title ?? "",
            writerNameLabel: news.author ?? "",
            target: self
        )
        
        titleWithDescriptionView.configure(
            titleLabel: news.title ?? "",
            descriptionLabel: news.description ?? ""
        )
        
        if let imageUrl = news.urlToImage {
            ImageClient.shared.setImage(from: imageUrl, placeholderImage: UIImage(named: "placeholder")) { [weak self] image in
                self?.imageView.image = image
            }
        }
    }
    
    @objc func backBtnTapped() {
            navigationController?.popViewController(animated: true)
        }
        
    @objc func bookMarkIconBtnTapped(sender: UIButton) {
        isBookmarked()
    }
    
    @objc func shareIconBtnTapped() {
        print("shareIconBtnTapped")
    }
    
    @objc func tagBtnTapped() {
    }
    
    private func isBookmarked(){
        guard let news = news else { return }
        
        // Проверяем, есть ли новость в закладках
        persistenceManager.retreiveNews { [weak self] result in
            switch result {
            case .success(let bookmarks):
                if bookmarks.contains(where: { $0.url == news.url }) {
                    // Новость уже в закладках, значит удаляем
                    self?.persistenceManager.updateWith(bookmark: news, actionType: .remove) { error in
                        if let error = error {
                            print("Ошибка при удалении закладки: \(error)")
                        } else {
                            print("Новость успешно удалена из закладок!")
                            self?.navigationBarComponent.updateBookmarkIcon(false)
                        }
                    }
                } else {
                    // Новость ещё не добавлена в закладки, добавляем
                    self?.persistenceManager.updateWith(bookmark: news, actionType: .add) { error in
                        if let error = error {
                            print("Ошибка при добавлении закладки: \(error)")
                        } else {
                            print("Новость успешно добавлена в закладки!")
                            self?.navigationBarComponent.updateBookmarkIcon(true)
                        }
                    }
                }
            case .failure(let error):
                print("Ошибка при получении закладок: \(error)")
            }
        }
    }
}

extension NewsDetailViewController {
    
    private func setupViews() {
        view.addSubview(imageView)
        stackView.addArrangedSubview(navigationBarComponent)
        stackView.addArrangedSubview(titleComponent)
        view.addSubview(stackView)
        view.addSubview(scrollView)
        scrollView.addSubview(titleWithDescriptionView)
        
        
        navigationBarComponent.translatesAutoresizingMaskIntoConstraints = false
        titleComponent.translatesAutoresizingMaskIntoConstraints = false
        titleWithDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.47)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            stackView.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            titleWithDescriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleWithDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleWithDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            titleWithDescriptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            titleWithDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
