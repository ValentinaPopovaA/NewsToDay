//
//  DescriptionView.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/23/24.
//

import UIKit

class DescriptionView: UIView {
    

    private lazy var titleLabel = UILabel.createLabel(
        text: "The latest situation in the presidential election",
        fontSize: 16,
        textColor: UIColor.blackPrimary!,
        isBold: true,
        textAlignment: .left
    )
    
    private lazy var descriptionLabel = UILabel.createLabel(
        text: "John Doe",
        fontSize: 16,
        textColor: UIColor.grayDark!,
        textAlignment: .justified,
        numberOfLines: 0
    )
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(titleLabel: String, descriptionLabel: String) {
        setUIDescriptionLabel(text: descriptionLabel)
        self.titleLabel.text = titleLabel
        
    }
    
    private func setUIDescriptionLabel(text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = 24
            paragraphStyle.maximumLineHeight = 24

        descriptionLabel.attributedText = NSAttributedString(string: text, attributes: [
            .paragraphStyle: paragraphStyle,
        ])
        descriptionLabel.textAlignment = .justified
    }
}

extension DescriptionView {
    
    private func setupViews() {
//        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
//            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
//        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}

