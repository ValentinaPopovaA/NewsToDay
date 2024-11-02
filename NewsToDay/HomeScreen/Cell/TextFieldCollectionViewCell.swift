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
    
    private lazy var mainView: UIView = {
        let element = UIView()
        element.backgroundColor = .grayLighter
        element.layer.cornerRadius = 12
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var searchButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        element.tintColor = .grayPrimary
        return element
    }()
    
    public lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.backgroundColor = .grayLighter
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .words
        textField.returnKeyType = .search
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(descriptionNewsLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainView)
        mainView.addSubview(searchButton)
        mainView.addSubview(searchTextField)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionNewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionNewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionNewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            mainView.topAnchor.constraint(equalTo: descriptionNewsLabel.bottomAnchor, constant: 32),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainView.heightAnchor.constraint(equalToConstant: 56),
            
            searchTextField.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: 25),
           
            searchButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
