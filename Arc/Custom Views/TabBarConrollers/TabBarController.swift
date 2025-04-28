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
        tabBar.tintColor = .systemPurple.withAlphaComponent(1.1)
        tabBar.unselectedItemTintColor = .systemPurple.withAlphaComponent(0.5)
    }
    
    
    func createDiscoverNC() -> UINavigationController {
        let DiscoverViewController =  DiscoverViewController()
        DiscoverViewController.title = "Discover"
        DiscoverViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        
        return UINavigationController(rootViewController: DiscoverViewController)
    }
    
    
    func CreateFavoritesNC() ->UINavigationController {
        let favoritsVC = FavoritesVC()
        favoritsVC.title = "Favorites"
        favoritsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritsVC)
    }
}


