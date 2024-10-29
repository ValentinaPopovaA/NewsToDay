//
//  HeaderView.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/23/24.
//

import UIKit

class HeaderView: UIView {
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bookmarkIconButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var shareIconButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(backBtn: Selector, bookMarkIconBtn: Selector, shareIconBtn: Selector, target: UIViewController) {
        print("configure start")
        backButton.addTarget(target, action: backBtn, for: .touchUpInside)
        bookmarkIconButton.addTarget(target, action: bookMarkIconBtn, for: .touchUpInside)
        shareIconButton.addTarget(target, action: shareIconBtn, for: .touchUpInside)
    }
}

extension HeaderView {
    
    private func setupViews() {
        addSubview(backButton)
        addSubview(bookmarkIconButton)
        addSubview(shareIconButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 72),
            
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            bookmarkIconButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            bookmarkIconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            bookmarkIconButton.widthAnchor.constraint(equalToConstant: 24),
            bookmarkIconButton.heightAnchor.constraint(equalToConstant: 24),
            
            shareIconButton.topAnchor.constraint(equalTo: bookmarkIconButton.bottomAnchor, constant: 24),
            shareIconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            shareIconButton.widthAnchor.constraint(equalToConstant: 24),
            shareIconButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}



