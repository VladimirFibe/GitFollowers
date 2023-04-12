import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScent = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScent)
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }
    
    private func createSearchNavigationController() -> UINavigationController {
        let search = SearchViewController()
        search.title = "Search"
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: search)
    }
    
    private func createFavoritesNavigationController() -> UINavigationController {
        let favorite = FavoritesListViewController()
        favorite.title = "Favorite"
        favorite.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favorite)
    }
    
    private func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        let search = createSearchNavigationController()
        let favorite = createFavoritesNavigationController()
        tabbar.viewControllers = [search, favorite]
        return tabbar
    }
}

