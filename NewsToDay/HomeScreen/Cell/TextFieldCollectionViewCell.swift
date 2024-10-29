//
//  TextFieldCollectionViewCell.swift
//  NewsToDay
//
//  Created by Валентина Попова on 29.10.2024.
//

import UIKit

final class TextFieldCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Browse"
        label.textColor = .blackDark
        label.font = .interBold
        return label
    }()
    
    private lazy var descriptionNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover things of this world"
        label.textColor = .grayPrimary
        label.font = UIFont.interRegular
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.backgroundColor = .grayLighter
        textField.layer.cornerRadius = 8
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(descriptionNewsLabel)
        contentView.addSubview(searchTextField)
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionNewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionNewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionNewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            searchTextField.topAnchor.constraint(equalTo: descriptionNewsLabel.bottomAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
