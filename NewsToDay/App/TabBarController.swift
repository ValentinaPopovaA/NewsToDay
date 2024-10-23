import UIKit

enum Tabs: Int {
    case browse
    case categories
    case bookmarks
    case profile
}

final class TabBarController: UITabBarController {
    
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
    
    
    private func configure() {
        tabBar.tintColor = .purplePrimary
        tabBar.barTintColor = .grayLight
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.grayLight?.cgColor ?? UIColor.gray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.cornerRadius = 12
        tabBar.layer.masksToBounds = true
        
        let browseViewController = UIViewController()
        browseViewController.view.backgroundColor = .cyan
        let categoriesViewController = UIViewController()
        let bookmarksViewController = UIViewController()
        let profileViewController = UIViewController()
        
        browseViewController.tabBarItem = UITabBarItem(title: nil,
                                                       image: UIImage(named: "browse"),
                                                       tag: Tabs.browse.rawValue)
        categoriesViewController.tabBarItem = UITabBarItem(title: nil,
                                                           image: UIImage(named: "categories"),
                                                           tag: Tabs.categories.rawValue)
        bookmarksViewController.tabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(named: "bookmarks"),
                                                          tag: Tabs.bookmarks.rawValue)
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                        image: UIImage(named: "profile"),
                                                        tag: Tabs.profile.rawValue)
        
        
        setViewControllers([
            browseViewController,
            categoriesViewController,
            bookmarksViewController,
            profileViewController
        ], animated: false)
        
        
    }
}

