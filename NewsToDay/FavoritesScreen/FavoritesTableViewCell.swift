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
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interRegular
        label.textColor = .grayLighter
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interBold
        label.numberOfLines = 2
        label.textColor = .blackDark
        return label
    }()
    
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    let placeholderImg = UIImage(named: "placeholderImage")
    
    //MARK: - Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteImage.image = nil
    }
    
    //MARK: - Public Setup
    
    func setupCell(news: News) {
        setupViews()
        guard let title = news.title, let sourse = news.source.name else { return }
        titleLabel.text = title
        categoryLabel.text = sourse
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Cell
    func setupImage(news: News) {
        guard let urlToImage = news.urlToImage else {
            favoriteImage.image = placeholderImg
            favoriteImage.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }
        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: placeholderImg
        ) { [weak self] image in
            guard let image else {
                self?.favoriteImage.image = image
                self?.favoriteImage.contentMode = .scaleAspectFill
                self?.loadingActivityIndicator.stopAnimating()
                return
            }
            self?.favoriteImage.image = image
            self?.favoriteImage.contentMode = .scaleAspectFill
            self?.loadingActivityIndicator.stopAnimating()
        }
    }
    
    private func setupViews() {
        contentView.addSubview(favoriteImage)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            favoriteImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteImage.widthAnchor.constraint(equalToConstant: 96),
            favoriteImage.heightAnchor.constraint(equalToConstant: 96),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
