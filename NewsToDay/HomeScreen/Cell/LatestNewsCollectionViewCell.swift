//
//  LatestNewsCollectionViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 29.10.2024.
//

import UIKit
import Kingfisher

final class LatestNewsCollectionViewCell: UICollectionViewCell {
    
    var bookMarkChangeColor: Bool = false
    
    lazy var latestNewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var topicNewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .interSemibold
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let element = UIButton()
        element.tintColor = .white
        element.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        element.addTarget(self, action: #selector(addToBookmarks), for: .touchUpInside)
        return element
    }()
    
    @objc private func addToBookmarks() {
        if bookMarkChangeColor == false {
            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookMarkButton.tintColor = .purplePrimary
            bookMarkChangeColor = true
//            guard let data = newsData else { return }
//            //print(data)
//            bookmarkManager.saveNewsToDefaults(news: data)
        } else {
            bookMarkButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            bookMarkButton.tintColor = .white
            bookMarkChangeColor = false
//            guard let data = newsData else { return }
//            //print(data)
//            bookmarkManager.deleteNewsFromDefaults(news: data)
        }
    }
    
    private let placeholderImg = UIImage(named: "placeholder")
    private let loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(latestNewsImage)
        contentView.addSubview(bookMarkButton)
        contentView.addSubview(topicNewsLabel)
        contentView.addSubview(newsLabel)
        contentView.addSubview(loadingActivityIndicator)
        
        latestNewsImage.translatesAutoresizingMaskIntoConstraints = false
        bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        topicNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            latestNewsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            latestNewsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            latestNewsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            latestNewsImage.heightAnchor.constraint(equalToConstant: 256),
            
            bookMarkButton.topAnchor.constraint(equalTo: latestNewsImage.topAnchor, constant: 24),
            bookMarkButton.trailingAnchor.constraint(equalTo: latestNewsImage.trailingAnchor, constant: -24),
            
            topicNewsLabel.topAnchor.constraint(equalTo: latestNewsImage.bottomAnchor, constant: -80),
            topicNewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            topicNewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            newsLabel.topAnchor.constraint(equalTo: topicNewsLabel.bottomAnchor, constant: 4),
            newsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            newsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: latestNewsImage.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: latestNewsImage.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(image: URL?, topic: String, news: String, newsData: News) {
        topicNewsLabel.text = topic
        newsLabel.text = news
        
        if let image = image {
            latestNewsImage.kf.setImage(with: image)
        } else {
            latestNewsImage.image = UIImage(named: "berlin")
        }
    }
}
