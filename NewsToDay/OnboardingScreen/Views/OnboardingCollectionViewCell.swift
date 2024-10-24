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

    private let topLabel = UILabel(font: .boldSystemFont(ofSize: 24) , textColor: .blackDark! )

    private let bottomLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: .gray)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .grayLighter
        addSubview(backgroundImageView)
        topLabel.textAlignment = .center
        addSubview(topLabel)
        bottomLabel.textAlignment = .center
        bottomLabel.numberOfLines = 4
        addSubview(bottomLabel)
    }
    
    public func cellConfigure(model: OnboardingStruct) {
        topLabel.text = model.topLabel
        bottomLabel.text = model.bottomLabel
        backgroundImageView.image = model.image
    }
    
    private func setConstraints() {
      
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 400),
 
            topLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -5),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            bottomLabel.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
}
