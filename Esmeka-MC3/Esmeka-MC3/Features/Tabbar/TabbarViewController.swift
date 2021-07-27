//
//  TabbarViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 25/07/21.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        set()
    }
    
}

private extension TabbarViewController {
    func set() {
        tabBar.tintColor = .blue
        setViewControllers([homeTabbar()], animated: true)
    }
    
    func homeTabbar() -> UINavigationController {
        let iconHome = "chart.bar.doc.horizontal.fill"
        let titleHome = "History"
        let homeVc = HomeViewController(nibName: HomeViewController.identifier, bundle: nil)
        let homeNavController = UINavigationController(rootViewController: homeVc)
        homeNavController.navigationItem.title = titleHome
        homeNavController.navigationBar.prefersLargeTitles = true
        homeNavController.tabBarItem = UITabBarItem(title: titleHome, image: UIImage(systemName: iconHome), tag: 1)
        return homeNavController
        
    }

}

