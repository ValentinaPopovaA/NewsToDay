//
//  NewsDetailViewController.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/22/24.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    
    let navigationBarComponent = HeaderView() // Вью с иконкой для возвращения назад, создание закладки и иконкой для шеринга.
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleComponent = TitleView() // Вью для отображения основной информации — тэга, заголовка статьи и подписи автора.
    let titleWithDescriptionView = DescriptionView() // Текстовый блок с заголовком статьи и её описанием.
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        configure()
    }
    
    private func configure() {
        navigationBarComponent.configure(
            backBtn: #selector(backBtnTapped),
            bookMarkIconBtn: #selector(bookMarkIconBtnTapped),
            shareIconBtn: #selector(shareIconBtnTapped),
            target: self
        )
        
        titleComponent.configure(
            tagTitle: "Politics",
            tagSelector: #selector(tagBtnTapped),
            titleLabel: "The latest situation in the presidential election",
            writerNameLabel: "John Doe",
            target: self
        )
        
        titleWithDescriptionView.configure(
            titleLabel: "Results",
            descriptionLabel: "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. \n  For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. \n  Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
        )
    }
    
    @objc func backBtnTapped() {
        print("backBtnTapped")
    }
    
    @objc func bookMarkIconBtnTapped() {
        print("bookMarkIconBtnTapped")
    }
    
    @objc func shareIconBtnTapped() {
        print("shareIconBtnTapped")
    }
    
    @objc func tagBtnTapped() {
        print("tagBtnTapped")
    }
}

extension NewsDetailViewController {
    
    private func setupViews() {
        view.addSubview(imageView)
        stackView.addArrangedSubview(navigationBarComponent)
        stackView.addArrangedSubview(titleComponent)
        view.addSubview(stackView)
        view.addSubview(scrollView)
        scrollView.addSubview(titleWithDescriptionView)
        
        
        navigationBarComponent.translatesAutoresizingMaskIntoConstraints = false
        titleComponent.translatesAutoresizingMaskIntoConstraints = false
        titleWithDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.47)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            stackView.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            titleWithDescriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleWithDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleWithDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            titleWithDescriptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            titleWithDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
