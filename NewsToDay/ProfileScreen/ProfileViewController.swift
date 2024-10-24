//
//  ProfileViewController.swift
//  NewsToDay
//
//  Created by Bakgeldi Alkhabay on 24.10.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profile"
        label.font = .interBold
        label.textColor = .blackDark
        return label
    }()
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 34
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dev P"
        label.font = .interSemibold
        label.textColor = .blackDark
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "dev@gmail.com"
        label.font = .interRegular?.withSize(14)
        label.textColor = .grayPrimary
        return label
    }()
    
    private let languageView = CustomView(
        text: "Language",
        image: UIImage(systemName: "chevron.right") ?? UIImage()
    )
    
    private let termsView = CustomView(
        text: "Terms & Conditions",
        image: UIImage(systemName: "chevron.right") ?? UIImage()
    )
    
    private let signOutView = CustomView(
        text: "Sign Out",
        image: UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? UIImage()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        setupButtons()
        [titleLabel, avatarImageView, nameLabel, emailLabel, languageView, signOutView, termsView].forEach { view.addSubview($0) }
    }
    
    private func setupButtons() {
        languageView.translatesAutoresizingMaskIntoConstraints = false
        signOutView.translatesAutoresizingMaskIntoConstraints = false
        termsView.translatesAutoresizingMaskIntoConstraints = false

        // Жест для languageView
        let languageTapGesture = UITapGestureRecognizer(target: self, action: #selector(languageViewTapped))
        languageView.addGestureRecognizer(languageTapGesture)
        languageView.isUserInteractionEnabled = true

        // Жест для termsView
        let termsTapGesture = UITapGestureRecognizer(target: self, action: #selector(termsViewTapped))
        termsView.addGestureRecognizer(termsTapGesture)
        termsView.isUserInteractionEnabled = true

        // Жест для signOutView
        let signoutTapGesture = UITapGestureRecognizer(target: self, action: #selector(signOutViewTapped))
        signOutView.addGestureRecognizer(signoutTapGesture)
        signOutView.isUserInteractionEnabled = true
    }

    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            avatarImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            avatarImageView.heightAnchor.constraint(equalToConstant: 72),
            avatarImageView.widthAnchor.constraint(equalToConstant: 72),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            languageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 44),
            languageView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            languageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            languageView.heightAnchor.constraint(equalToConstant: 56),
            
            termsView.bottomAnchor.constraint(equalTo: signOutView.topAnchor, constant: -28),
            termsView.leadingAnchor.constraint(equalTo: languageView.leadingAnchor),
            termsView.trailingAnchor.constraint(equalTo: languageView.trailingAnchor),
            termsView.heightAnchor.constraint(equalTo: languageView.heightAnchor),
            
            signOutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            signOutView.leadingAnchor.constraint(equalTo: languageView.leadingAnchor),
            signOutView.trailingAnchor.constraint(equalTo: languageView.trailingAnchor),
            signOutView.heightAnchor.constraint(equalTo: languageView.heightAnchor),
            
        ])
    }
    
    @objc private func languageViewTapped() {
        print("language tapped!")
    }
    
    @objc private func termsViewTapped() {
        let termsViewController = TermsViewController()
        
        termsViewController.modalTransitionStyle = .coverVertical
        termsViewController.modalPresentationStyle = .fullScreen
        self.present(termsViewController, animated: true, completion: nil)
    }
    
    @objc private func signOutViewTapped() {
        print("sign out tapped!")
    }
}
