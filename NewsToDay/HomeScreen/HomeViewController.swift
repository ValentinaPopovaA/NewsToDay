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
    private let persistenceManager: PersistenceManagerProtocol = PersistenceManager.shared
    
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
    
    // MARK: - Fetch Data Methods
    
    private func fetchDataRecNews() {
        let categories = catManager.all.map { $0.name }
        let request = BrowseRecommendationRequest(category: Category(name: categories.joined(separator: ","), icon: ""))
        
        newsManager.request(request) { [weak self] result in
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
        let request = TopHeadlinesRequest(category: Category(name: "general", icon: ""), page: 1)
        
        newsManager.request(request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Фильтрация пустых новостей
                    self?.newsData = data!.filter { news in
                        return !(news.title?.isEmpty ?? true) && !(news.urlToImage?.isEmpty ?? true)
                    }
                    self?.homeView.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Setup UI and Delegates
    
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
    
    // MARK: - Layout Configuration
    
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, LatestNewsCollectionViewCellDelegate {
    func didTapBookmark(for news: News, bookMarkBtn: UIButton) {
        print("Новость добавлена в закладки: \(news.title ?? "Без названия")")
        isBookmarked(news, bookMarkBtn)
    }
    
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath) as? LatestNewsCollectionViewCell else {
                return UICollectionViewCell()
                
            }
                cell.delegate = self

            if let news = newsData?[indexPath.row] {
                let imageUrl = news.urlToImage != nil ? URL(string: news.urlToImage!) : nil
                let topic = news.source.name ?? "ТЕМА"
                let newsTitle = news.title ?? "НОВОСТЬ"

                cell.configureCell(image: imageUrl, topic: topic, news: newsTitle, newsData: news)
            } else {
                cell.latestNewsImage.image = UIImage(named: "city_6")
                cell.newsLabel.text = "НОВОСТЬ"
                cell.topicNewsLabel.text = "ТЕМА"
            }

            return cell
        case .recommended:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendedNewsCollectionViewCell", for: indexPath) as! RecomendedNewsCollectionViewCell
            if let news = recNewsData?[indexPath.row] {
                cell.configureCell(image: URL(string: news.urlToImage ?? ""), topic: news.source.name ?? "", news: news.title ?? "", newsData: news)
                print("Cell Recomended index - \(indexPath.row)")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNews: News?
        
        switch sections[indexPath.section] {
        case .news:
            selectedNews = newsData?[indexPath.row]
        case .recommended:
            selectedNews = recNewsData?[indexPath.row]
        default:
            return
        }
        
        if let selectedNews = selectedNews {
            let detailVC = NewsDetailViewController()
            detailVC.news = selectedNews
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    private func isBookmarked(_ news: News, _ bookMarkBtn: UIButton){
        
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
                            bookMarkBtn.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
                        }
                    }
                } else {
                    // Новость ещё не добавлена в закладки, добавляем
                    self?.persistenceManager.updateWith(bookmark: news, actionType: .add) { error in
                        if let error = error {
                            print("Ошибка при добавлении закладки: \(error)")
                        } else {
                            print("Новость успешно добавлена в закладки!")
                            bookMarkBtn.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                        }
                    }
                }
            case .failure(let error):
                print("Ошибка при получении закладок: \(error)")
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    func fetchSearchData(query: String) {
        let searchRequest = SearchResultRequest(searchText: query, page: 1)
        guard let url = searchRequest.url else {
            print("Ошибка создания URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Ошибка запроса: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Данные не получены")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(NewsModel.self, from: data)
                    self.newsData = decodedData.articles
                    self.homeView.collectionView.reloadSections(IndexSet(integer: 2))
                } catch {
                    print("Ошибка декодирования: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Введите запрос"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let search = textField.text {
            fetchSearchData(query: search)
        }
    }
}
