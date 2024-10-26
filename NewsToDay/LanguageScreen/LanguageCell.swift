//
//  LanguageCell.swift
//  NewsToDay
//
//  Created by Bakgeldi Alkhabay on 26.10.2024.
//

import UIKit

class LanguageCell: UITableViewCell {
    static let reuseIdentifier = "LanguageCell"
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interRegular
        label.textColor = .grayDark
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .clear
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(languageLabel)
        contentView.addSubview(checkmarkImageView)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            languageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkmarkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with language: String, isSelected: Bool) {
        languageLabel.text = language
        updateAppearance(isSelected: isSelected)
    }
    
    private func updateAppearance(isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .purplePrimary
            languageLabel.textColor = .white
            checkmarkImageView.tintColor = .white
        } else {
            contentView.backgroundColor = .grayLighter
            languageLabel.textColor = .black
            checkmarkImageView.tintColor = .clear
        }
    }
}
