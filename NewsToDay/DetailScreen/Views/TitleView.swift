//
//  TitleComponent.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/23/24.
//

import UIKit

class TitleView: UIView {
    
    private lazy var tagButton: UIButton = UIButton()
    
    private lazy var titleLabel = UILabel.createLabel(
        text: "The latest situation in the presidential election",
        fontSize: 20,
        textColor: UIColor.white,
        isBold: true,
        textAlignment: .left,
        numberOfLines: 2
    )
    
    private lazy var writerNameLabel = UILabel.createLabel(
        text: "John Doe",
        fontSize: 16,
        textColor: UIColor.white,
        isBold: true
    )
    
    private lazy var writerLabel = UILabel.createLabel(
        text: "Author",
        fontSize: 16,
        textColor: UIColor.grayLight!
        
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tagTitle: String, tagSelector: Selector, titleLabel: String, writerNameLabel: String, target: UIViewController) {
        
        tagButton = UIButton().makeButtonwithLabel(
            label: tagTitle,
            buttonColor: .purplePrimary,
            textColor: .white,
            target: target,
            action: tagSelector)
        
        self.titleLabel.text = titleLabel
        self.writerNameLabel.text = writerNameLabel
        self.writerLabel.text = "Author"
        
        setupViews()
        setConstraints()
    }

}

extension TitleView {
    
    private func setupViews() {
        addSubview(tagButton)
        addSubview(titleLabel)
        addSubview(writerNameLabel)
        addSubview(writerLabel)
        
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        writerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        writerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tagButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            tagButton.widthAnchor.constraint(equalToConstant: 75),
            tagButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: tagButton.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalToConstant: 336)
        ])
        
        NSLayoutConstraint.activate([
            writerNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            writerNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            writerLabel.topAnchor.constraint(equalTo: writerNameLabel.bottomAnchor, constant: 0),
            writerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        ])
    }
}


