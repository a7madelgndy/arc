//
//  ArcTabBarController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createDiscoverNC(), CreateFavoritesNC()]
        tabBar.tintColor = Colors.main
        tabBar.unselectedItemTintColor = .systemPurple.withAlphaComponent(0.5)
    }
    
    
    func createDiscoverNC() -> UINavigationController {
        let DiscoverViewController =  DiscoverViewController()
        DiscoverViewController.title = "Discover"
        DiscoverViewController.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.home, selectedImage: SFSymbols.homeFill)
        
        return UINavigationController(rootViewController: DiscoverViewController)
    }
    
    
    func CreateFavoritesNC() ->UINavigationController {
        let favoritsVC = FavoritesVC()
        favoritsVC.title = "Favorites"
        favoritsVC.tabBarItem = UITabBarItem(title: "Favorites", image: SFSymbols.heart, selectedImage: SFSymbols.heartFill)

        return UINavigationController(rootViewController: favoritsVC)
    }
}


