//
//  CategoriesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 28.10.2024.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let id = "CategoryCell"
    
    // MARK: - UI Elements
    var titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .purplePrimary
                titleLabel.textColor = .white
                
            } else {
                backgroundColor = .white
                titleLabel.textColor = .grayDark
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupUICell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUICell() {
        layer.masksToBounds = false
        layer.cornerRadius = 15
    }
    
    func configure(with category: Category) {
        titleLabel.text = "\(category.icon) \(category.name.capitalized)"
        titleLabel.textColor = .grayDark
        titleLabel.font = .interSemibold
    }
    
    private func setupViews() {
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.grayLighter?.cgColor
    }
    
    private func setupConstraints() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
}
