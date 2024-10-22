//
//  EmptyStateView.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

class EmptyStateView: UIView {
    
    private let iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purpleLighter
        view.layer.cornerRadius = 36
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "text.book.closed")
        imageView.tintColor = .purplePrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let messageLabel = UILabel.createLabel(
        text: "You haven't saved any articles yet. Start reading and bookmarking them now.",
        fontSize: 16,
        textColor: .blackDark ?? .black
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(iconContainerView)
        addSubview(iconImageView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            iconContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconContainerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            iconContainerView.widthAnchor.constraint(equalToConstant: 72),
            iconContainerView.heightAnchor.constraint(equalToConstant: 72),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            messageLabel.topAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
}
