//
//  ViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 20.10.2024.
//

import UIKit

enum SectionType {
    case textField
    case topics
    case news
    case recommended
}

final class HomeViewController: UIViewController {
    
    private let catManager = CategoryManager()
    private let homeView = HomeView()
    private let newsManager = DefaultNetworkService()
    private var previousSelectedIndex: IndexPath?
    private var recNewsData: [News]?
    private var newsData: [News]?
    
    private let sections: [SectionType] = [.textField, .topics, .news, .recommended]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        setupViews()
        setDelegates()
        fetchDataNews()
        fetchDataRecNews()
    }
    
    private func fetchDataRecNews() {
        let categories = catManager.all.map { $0.name }
        newsManager.request(BrowseRecommendationRequest(category: Category(name: categories.joined(separator: ","), icon: ""))) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.recNewsData = data
                    self?.homeView.collectionView.reloadSections(IndexSet(integer: 3))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchDataNews() {
        newsManager.request(TopHeadlinesRequest(category: Category(name: "health", icon: ""), page: 1)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.newsData = data
                    self?.homeView.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setupViews() {
        homeView.collectionView.register(TextFieldCollectionViewCell.self, forCellWithReuseIdentifier: "TextFieldCollectionViewCell")
        homeView.collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        homeView.collectionView.register(LatestNewsCollectionViewCell.self, forCellWithReuseIdentifier: "LatestNewsCollectionViewCell")
        homeView.collectionView.register(RecomendedNewsCollectionViewCell.self, forCellWithReuseIdentifier: "RecomendedNewsCollectionViewCell")
        homeView.collectionView.collectionViewLayout = createLayout()
        view.addSubview(homeView.collectionView)
        homeView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeView.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setDelegates() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            switch self.sections[sectionIndex] {
            case .textField:
                return self.createTextFieldSection()
            case .topics:
                return self.createTopicSection()
            case .news:
                return self.createNewsSection()
            case .recommended:
                return self.createRecommendedNewsSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        return section
    }
    
    private func createTextFieldSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(195)), subitems: [item])
        return createLayoutSection(group: group, behavior: .none, interGroupSpacing: 16)
    }
    
    private func createTopicSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(32)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    private func createNewsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(256), heightDimension: .absolute(256)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    private func createRecommendedNewsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(256)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        return section
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .textField:
            return 1
        case .topics:
            return catManager.all.count
        case .news:
            return newsData?.count ?? 0
        case .recommended:
            return min(recNewsData?.count ?? 0, 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .textField:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldCollectionViewCell", for: indexPath) as! TextFieldCollectionViewCell
            cell.searchTextField.delegate = self
            return cell
        case .topics:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            let category = catManager.all[indexPath.row]
            cell.configureCell(topicName: category.name)
            return cell
        case .news:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as! LatestNewsCollectionViewCell
            if let news = newsData?[indexPath.row] {
                cell.configureCell(image: URL(string: news.urlToImage ?? ""), topic: news.source.name ?? "", news: news.title ?? "", newsData: news)
            }
            return cell
        case .recommended:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedNewsCollectionViewCell", for: indexPath) as! RecomendedNewsCollectionViewCell
            if let news = newsData?[indexPath.row] {
                cell.configureCell(image: URL(string: news.urlToImage ?? ""), topic: news.source.name ?? "", news: news.title ?? "", newsData: news)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNews: News
        switch sections[indexPath.section] {
        case .news:
            selectedNews = (newsData?[indexPath.row])!
        case .recommended:
            selectedNews = (recNewsData?[indexPath.row])!
        default:
            return
        }
        
        let detailVC = NewsDetailViewController()
        detailVC.news = selectedNews
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    private func fetchSearchData(query: String) {
        // Проверка, что текст поиска не пустой
        guard !query.isEmpty else { return }
        
        // Выполнение сетевого запроса
        newsManager.request(SearchResultRequest(searchRequest: query, page: 1)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data = data, !data.isEmpty {
                        // Успешный запрос: обновляем данные и интерфейс
                        self?.newsData = data
                        self?.homeView.collectionView.reloadSections(IndexSet(integer: 2))
                    } else {
                        // Обработка пустого ответа, если данные отсутствуют
                        self?.showAlert(message: "По вашему запросу ничего не найдено")
                    }
                case .failure(let error):
                    // Обработка ошибки
                    self?.handleError(error)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // Закрывает клавиатуру
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Выполняем поиск, если текст в поле поиска существует
        if let query = textField.text {
            fetchSearchData(query: query)
        }
    }
    
    // Показать сообщение об ошибке пользователю
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func handleError(_ error: Error) {
        var errorMessage = "Произошла ошибка. Повторите попытку позже."
        
        if let nsError = error as NSError? {
            errorMessage = nsError.localizedDescription
        } else if let newsError = error as? NewsError {
            errorMessage = newsError.rawValue
        } else if let errorResponse = error as? ErrorResponse {
            errorMessage = errorResponse.description
        }
        
        showAlert(message: errorMessage)
    }
}

