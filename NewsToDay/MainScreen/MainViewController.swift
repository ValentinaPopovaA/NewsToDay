//
//  ViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 20.10.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .orange
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let sections = MockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupViews()
        setConstraints()
        setDelegates()
        
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.register(NewsPreviewCell.self, forCellWithReuseIdentifier: NewsPreviewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

//MARK: - Create Layout

extension MainViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .category(_):
                return self.createCategorySection()
            case .newsPreview(_):
                return self.createNewsPreviewSection()
            }
        }
        
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behaviior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     suplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behaviior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = suplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        
        return section
    }
    
    private func createNewsPreviewSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(256),
                                                            heightDimension: .absolute(256)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(256),
                                                                         heightDimension: .absolute(256)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behaviior: .groupPaging,
                                          interGroupSpacing: 16,
                                          suplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 24, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(80),
                                                            heightDimension: .absolute(32)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(80),
                                                                         heightDimension: .absolute(32)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behaviior: .continuous,
                                          interGroupSpacing: 16,
                                          suplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 24, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
}

//MARK: - UIColelctionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .category(let category):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
            cell.backgroundColor = .red
            return cell
        case .newsPreview(let newsPreview):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsPreviewCell.identifier, for: indexPath) as? NewsPreviewCell else { return UICollectionViewCell()}
            cell.configure(item: newsPreview[indexPath.item])
            return cell
        }
    }
    
}


//MARK: - Set constraints

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}

