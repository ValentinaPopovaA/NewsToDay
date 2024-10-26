//
//  LanguageViewController.swift
//  NewsToDay
//
//  Created by Bakgeldi Alkhabay on 26.10.2024.
//
import UIKit

final class LanguageViewController: UIViewController {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Language"
        label.font = .interBold
        label.textColor = .blackDark
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .grayPrimary
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var selectedLanguageIndex: IndexPath?
    private let languages = ["English", "Russian"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addButtonAction()
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [titleLabel, backButton, tableView].forEach { view.addSubview($0) }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 144) // Увеличили высоту для учета пустой ячейки
        ])
    }
    
    private func addButtonAction() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let emptyCell = UITableViewCell()
            emptyCell.backgroundColor = .clear
            emptyCell.isUserInteractionEnabled = false
            return emptyCell
        }
        
        let languageIndex = indexPath.row > 1 ? 1 : 0
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseIdentifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }
        
        let isSelected = IndexPath(row: languageIndex, section: 0) == selectedLanguageIndex
        cell.configure(with: languages[languageIndex], isSelected: isSelected)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 { return }
        
        selectedLanguageIndex = indexPath.row > 1 ? IndexPath(row: 1, section: 0) : IndexPath(row: 0, section: 0)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 16 : 56
    }
}
