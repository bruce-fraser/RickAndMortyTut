//
//  ViewController.swift
//  YouTutorial1
//
//  Created by Bruce Fraser on 3/7/23.
//

import UIKit

final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpTabs()
    }
    
    private func setUpTabs() {
        let charcterVC = RMCharacterViewController(); charcterVC.title = "Characters"
        let locationVC = RMLocationViewController(); locationVC.title = "Locations"
        let episodeVC = RMEpisodeViewController(); episodeVC.title = "Episodes"
        let settingsVC = RMSettingsViewController(); settingsVC.title = "Settings"
        
        charcterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: charcterVC)
        let nav2 = UINavigationController(rootViewController: locationVC)
        let nav3 = UINavigationController(rootViewController: episodeVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}

