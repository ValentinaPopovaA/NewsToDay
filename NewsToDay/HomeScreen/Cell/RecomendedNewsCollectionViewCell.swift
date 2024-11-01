//
//  RecomendedNewsCollectionViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 29.10.2024.
//

import UIKit

final class RecomendedNewsCollectionViewCell: UICollectionViewCell {
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var newsTopicLabel: UILabel = {
        let label = UILabel()
        label.font = .interRegular
        label.textColor = .grayPrimary
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .blackPrimary
        label.numberOfLines = 2
        return label
    }()
    
    private let placeholderImg = UIImage(named: "placeholder")
    private let loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImage)
        contentView.addSubview(newsTopicLabel)
        contentView.addSubview(newsLabel)
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        newsTopicLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: 96),
            cellImage.heightAnchor.constraint(equalToConstant: 96),
            
            newsTopicLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsTopicLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            newsTopicLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            newsLabel.topAnchor.constraint(equalTo: newsTopicLabel.bottomAnchor, constant: 5),
            newsLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            newsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: newsTopicLabel.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: newsTopicLabel.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(image: URL?, topic: String, news: String, newsData: News) {
        newsTopicLabel.text = topic
        newsLabel.text = news
        setupImage(news: newsData)
    }
    
    func setupImage(news: News) {
        loadingActivityIndicator.startAnimating()
        guard let urlToImage = news.urlToImage else {
            cellImage.image = placeholderImg
            cellImage.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }
        
        ImageClient.shared.setImage(from: urlToImage, placeholderImage: placeholderImg) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.cellImage.image = image ?? self.placeholderImg
                self.cellImage.contentMode = .scaleAspectFill
                self.loadingActivityIndicator.stopAnimating()
            }
        }
    }
}
