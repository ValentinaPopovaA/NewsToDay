//
//  CategoriesCollectionViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 29.10.2024.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .grayPrimary
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .purplePrimary
                categoryLabel.textColor = .white
                
            } else {
                backgroundColor = .grayLighter
                categoryLabel.textColor = .grayDark
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupUICell()
    }
    
    func setupUICell() {
        backgroundColor = .grayLighter
        layer.masksToBounds = false
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 32),
            categoryLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configureCell(topicName: String) {
        categoryLabel.text = topicName
    }
}
