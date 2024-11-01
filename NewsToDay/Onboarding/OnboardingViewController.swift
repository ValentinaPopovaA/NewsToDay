//
//  Untitled.swift
//  NewsToDay
//
//  Created by apple on 10/23/24.
//

import UIKit

struct OnboardingStruct {
    let topLabel: String
    let bottomLabel: String
    let image: UIImage
}

class OnboardingViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    
    // MARK: Properties
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purpleDark
        button.layer.cornerRadius = 12
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControl = CustomPageControl()
    
    
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let layout = CustomLayout()
    
    private let idOnboardingCell = "idOnboardingCell"
    
    private var onboardingArray = [OnboardingStruct]()
    
    private var collectionItem = 0
    
    private var itemW: CGFloat {
        return screenWidth * 0.4 * 1.45
    }
    
    private var itemH: CGFloat {
        return itemW * 1.6
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupOnboardingData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard onboardingArray.count > 1 else { return }

        // Прокрутка к второй ячейке
        collectionItem = 1
        let indexPath = IndexPath(item: collectionItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = collectionItem

        // Вызываем анимацию увеличения после прокрутки
        if let cell = collectionView.cellForItem(at: indexPath) {
            transformCell(cell, isEffect: true)
        } else {
            // Если ячейка еще не загружена, подождем немного
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if let cell = self.collectionView.cellForItem(at: indexPath) {
                    self.transformCell(cell, isEffect: true)
                }
            }
        }
    }
    
    // MARK: Setups
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(nextButton)
        
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.isScrollEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10.0, left: 50.0, bottom: 10.0, right: 50.0)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50.0
        layout.minimumInteritemSpacing = 50.0
        layout.itemSize.width = itemW
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 1
        pageControl.backgroundColor = .clear
        pageControl.contentMode = .center
        view.addSubview(pageControl)
        setConstraints()
    }
    
    private func setupOnboardingData() {
        
        guard let imageZero = UIImage(named: "toronto"),
              let imageFirst = UIImage(named: "berlin"),
              let imageSecond = UIImage(named: "toronto"),
              let imageThird = UIImage(named: "vancouver"),
              let imageForth = UIImage(named: "vancouver") else {
            print("Error: Image not found")
            return
        }
        
        onboardingArray = [
            OnboardingStruct(topLabel: "",
                             bottomLabel: "",
                             image: imageZero),
            
            OnboardingStruct(topLabel: "Browse",
                             bottomLabel: "Discover things of this world.",
                             image: imageSecond),
            
            OnboardingStruct(topLabel: "Bookmarks",
                             bottomLabel: "Saved articles to the library",
                             image: imageThird),
            
            OnboardingStruct(topLabel: "Browse",
                             bottomLabel: "Discover things of this world.",
                             image: imageSecond),
            
            OnboardingStruct(topLabel: "",
                             bottomLabel: "",
                             image: imageForth)
        ]
    }
    
    @objc private func nextButtonTapped() {
        if collectionItem == 2 {
            nextButton.setTitle("Get Started", for: .normal)
            print("Button")
        }
        
        if collectionItem < onboardingArray.count - 1 {
            // Увеличиваем индекс текущей ячейки
            collectionItem += 1
            let indexPath = IndexPath(item: collectionItem, section: 0)
            
            // Обновляем текущую страницу в кастомном лэйауте
            if let layout = collectionView.collectionViewLayout as? CustomLayout {
                layout.currentPage = collectionItem
            }
            
            // Прокручиваем к следующей ячейке
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem
            
            // Получаем текущую ячейку и увеличиваем её
            if let cell = collectionView.cellForItem(at: indexPath) {
                transformCell(cell, isEffect: true)
            }
            
            // Уменьшаем размеры предыдущей ячейки
            let previousIndexPath = IndexPath(item: collectionItem - 1, section: 0)
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) {
                transformCell(previousCell, isEffect: false)
            }
        } else {
            saveUserDefaults()
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed")
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Количество элементов в секции: \(onboardingArray.count)")
        return onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model, totalPages: onboardingArray.count, currentPage: indexPath.row)
        print("Создание ячейки \(indexPath.row)")
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension OnboardingViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemW, height: itemH + 150)
    }
}

// MARK: UIScrollViewDelegate

extension OnboardingViewController {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    private func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        UIView.animate(withDuration: 0.2) {
            cell.transform = isEffect ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity
        }
        
        for otherCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: otherCell) {
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
}

extension OnboardingViewController {
    
    private func setConstraints() {
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 510),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 90),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            collectionView.heightAnchor.constraint(equalToConstant: screenWidth + 300)
        ])
    }
}
