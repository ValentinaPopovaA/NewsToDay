//
//  CustomView.swift
//  NewsToDay
//
//  Created by Bakgeldi Alkhabay on 22.10.2024.
//

import UIKit

class CustomView: UIView {
    private let label = UILabel()
    private let imageView = UIImageView()

    init(text: String, image: UIImage) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()

        label.text = text
        imageView.image = image
        
        layer.cornerRadius = 12
        backgroundColor = .grayLighter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        addSubview(label)
        addSubview(imageView)

        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .interMedium
        label.textColor = .grayDark
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .grayDark
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
