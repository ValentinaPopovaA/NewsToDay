import UIKit

enum Tabs: Int {
    case browse
    case categories
    case bookmarks
    case profile
}

final class TabBarController: UITabBarController {
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        showOnboarding()
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let newHeight: CGFloat = 100
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = newHeight
        tabBarFrame.origin.y = view.frame.height - newHeight
        tabBar.frame = tabBarFrame
    }
    
    override func viewDidLoad() {
        configure()
    }
    
//    private func showOnboarding() {
//        let userDefaults = UserDefaults.standard
//        let onBoardinngWasViewed = userDefaults.bool(forKey: "OnBoardingWasViewed")
//        if onBoardinngWasViewed == false {
//            let onboardingViewController = OnboardingViewController()
//            onboardingViewController.modalPresentationStyle = .fullScreen
//            present(onboardingViewController, animated: true)
//        }
//    }
    
    private func configure() {
        tabBar.tintColor = .purplePrimary
        tabBar.barTintColor = .grayLight
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.grayLight?.cgColor ?? UIColor.gray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.cornerRadius = 12
        tabBar.layer.masksToBounds = true
        
        let browseNavController = UINavigationController(rootViewController: HomeViewController())
        let categoriesNavController = UINavigationController(rootViewController: CategoriesViewController())
        let bookmarksNavController = UINavigationController(rootViewController: FavoritesViewController())
        let profileNavController = UINavigationController(rootViewController: ProfileViewController())
        
        browseNavController.tabBarItem = UITabBarItem(title: nil,
                                                      image: UIImage(named: "browse"),
                                                      tag: Tabs.browse.rawValue)
        categoriesNavController.tabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(named: "categories"),
                                                          tag: Tabs.categories.rawValue)
        bookmarksNavController.tabBarItem = UITabBarItem(title: nil,
                                                         image: UIImage(named: "bookmarks"),
                                                         tag: Tabs.bookmarks.rawValue)
        profileNavController.tabBarItem = UITabBarItem(title: nil,
                                                       image: UIImage(named: "profile"),
                                                       tag: Tabs.profile.rawValue)
        
        setViewControllers([
            browseNavController,
            categoriesNavController,
            bookmarksNavController,
            profileNavController
        ], animated: false)
        
        
    }
}

