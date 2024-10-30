//
//  OnboardingCollectionViewCell.swift
//  NewsToDay
//
//  Created by apple on 10/23/24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
   // private let topLabel = UILabel(font: .boldSystemFont(ofSize: 20), textColor: .black)
    //private let bottomLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: .gray)
    
    private let topLabel: UILabel = {
            return UILabel.createLabel(
                text: "Hello, World!",
                fontSize: 20,
                textColor: .black,
                isBold: true,
                textAlignment: .center,
                numberOfLines: 1
            )
        }()
    
    private let bottomLabel: UILabel = {
            return UILabel.createLabel(
                text: "Hello, World!",
                fontSize: 16,
                textColor: .gray,
                isBold: true,
                textAlignment: .center,
                numberOfLines: 4
            )
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backgroundImageView)
        addSubview(topLabel)
        bottomLabel.numberOfLines = 4
        addSubview(bottomLabel)

    }
    
    public func cellConfigure(model: OnboardingStruct, totalPages: Int, currentPage: Int) {
        topLabel.text = model.topLabel
        bottomLabel.text = model.bottomLabel
        backgroundImageView.image = model.image
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            topLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 40),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 16),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        ])
    }
}

