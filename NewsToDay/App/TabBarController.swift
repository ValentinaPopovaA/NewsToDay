import UIKit

enum Tabs: Int {
    case browse
    case categories
    case bookmarks
    case profile
}

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        configure()
    }
    
    
    private func configure() {
        tabBar.tintColor = .purplePrimary
        tabBar.barTintColor = .grayLight
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 12
        tabBar.layer.masksToBounds = true
        
        let browseViewController = UIViewController()
        let categoriesViewController = UIViewController()
        let bookmarksViewController = UIViewController()
        let profileViewController = UIViewController()
        
        browseViewController.tabBarItem = UITabBarItem(title: nil,
                                                       image: UIImage(systemName: "house"),
                                                       tag: Tabs.browse.rawValue)
        categoriesViewController.tabBarItem = UITabBarItem(title: nil,
                                                           image: UIImage(systemName: "square.grid.2x2"),
                                                           tag: Tabs.categories.rawValue)
        bookmarksViewController.tabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(systemName: "bookmark"),
                                                          tag: Tabs.bookmarks.rawValue)
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                        image: UIImage(systemName: "person"),
                                                        tag: Tabs.profile.rawValue)
        
        setViewControllers([
            browseViewController,
            categoriesViewController,
            bookmarksViewController,
            profileViewController
        ], animated: false)
        
        
    }
}

