//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 28.10.2024.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    // MARK: - Properties
    private let categoryManager = CategoryManager()
    private var collectionView: UICollectionView!
    private var selectedCategories: [Category] = [] {
        didSet {
            saveSelectedCategoryNames()
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.textColor = .blackDark
        label.font = .interBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Thousands of articles in each category"
        label.textColor = .grayPrimary
        label.font = UIFont.interRegular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setupConstraints()
        loadSelectedCategoryNames()
        print(selectedCategories)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSelectedCategoryNames()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - 48) / 2, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        view.addSubview(descriptionLabel)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Save to UserDefaults
    private func saveSelectedCategoryNames() {
        let categoryNames = selectedCategories.map { $0.name }
        UserDefaults.standard.set(categoryNames, forKey: "SelectedCategoryNames")
    }
    
    // MARK: - Load from UserDefaults
    private func loadSelectedCategoryNames() {
        if let savedCategoryNames = UserDefaults.standard.array(forKey: "SelectedCategoryNames") as? [String] {
            selectedCategories = categoryManager.all.filter { savedCategoryNames.contains($0.name) }
            
            for (index, category) in categoryManager.all.enumerated() {
                if savedCategoryNames.contains(category.name) {
                    let indexPath = IndexPath(item: index, section: 0)
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryManager.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as! CategoryCollectionViewCell
        let category = categoryManager.all[indexPath.row]
        cell.configure(with: category)
        cell.isSelected = selectedCategories.contains(category)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryManager.all[indexPath.row]
        
        if !selectedCategories.contains(selectedCategory) {
            selectedCategories.append(selectedCategory)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let deselectedCategory = categoryManager.all[indexPath.row]
        
        if let index = selectedCategories.firstIndex(of: deselectedCategory) {
            selectedCategories.remove(at: index)
            saveSelectedCategoryNames()
        }
    }
}
