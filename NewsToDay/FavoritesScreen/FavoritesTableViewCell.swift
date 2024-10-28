//
//  FavoritesTableViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    static let reuseID = "FavoriteCell"
    
    // MARK: - UI Components
    private let favoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interRegular
        label.textColor = .grayLight
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = UIColor(named: "blackDark") ?? .black
        return label
    }()
    
    let placeholderImg = UIImage(named: "placeholderImage")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteImage.backgroundColor = .red
//        favoriteImage.image = nil
    }
    
    // MARK: - Public Setup Method
    func setupCell(news: News) {
        titleLabel.text = news.title
        categoryLabel.text = news.source.name
        favoriteImage.backgroundColor = .red
//        if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
//            loadImage(from: url)
//        } else {
//            favoriteImage.image = placeholderImg
//        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.favoriteImage.image = image
                }
            }
        }.resume()
    }
    
    private func setupViews() {
        contentView.addSubview(favoriteImage)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            favoriteImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteImage.widthAnchor.constraint(equalToConstant: 96),
            favoriteImage.heightAnchor.constraint(equalToConstant: 96),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

//    // MARK: - Configure Cell
//    func setupImage(news: News) {
//        guard let urlToImage = news.urlToImage else {
//            favoriteImage.image = placeholderImg
//            favoriteImage.contentMode = .scaleAspectFill
//            loadingActivityIndicator.stopAnimating()
//            return
//        }
//        ImageClient.shared.setImage(
//            from: urlToImage,
//            placeholderImage: placeholderImg
//        ) { [weak self] image in
//            guard let image else {
//                self?.favoriteImage.image = image
//                self?.favoriteImage.contentMode = .scaleAspectFill
//                self?.loadingActivityIndicator.stopAnimating()
//                return
//            }
//            self?.favoriteImage.image = image
//            self?.favoriteImage.contentMode = .scaleAspectFill
//            self?.loadingActivityIndicator.stopAnimating()
//        }
//    }
