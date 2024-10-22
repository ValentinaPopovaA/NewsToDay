//
//  FavoritesTableViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.interSemibold
        label.textColor = .blackPrimary
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.interRegular
        label.textColor = .blackLighter
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(articleImageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleImageView.widthAnchor.constraint(equalToConstant: 96),
            articleImageView.heightAnchor.constraint(equalToConstant: 96),
            
            categoryLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            categoryLabel.topAnchor.constraint(equalTo:  articleImageView.topAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 12)
        ])
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        categoryLabel.text = article.category
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            articleImageView.image = UIImage(systemName: "photo") // Загрузка изображения (заглушка)
        }
    }
}
