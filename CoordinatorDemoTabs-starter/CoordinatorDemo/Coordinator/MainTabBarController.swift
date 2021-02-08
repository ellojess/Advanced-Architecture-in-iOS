//
//  MainTabBarController.swift
//  CoordinatorDemo
//
//  Created by Adriana González Martínez on 2/7/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    var home : HomeCoordinator!
    var setting: SettingsCoordinator!
    var message: MessagesCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        home = HomeCoordinator(navigationController: NavigationController(rootViewController: homeVC))
        
        let settingsVC = SettingsVC()
        settingsVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "house"), tag: 1)
        setting = SettingsCoordinator(navigationController: NavigationController(rootViewController: settingsVC))
        
        let messageVC = MessagesVC()
        messageVC.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "house"), tag: 2)
        message = MessagesCoordinator(navigationController: NavigationController(rootViewController: messageVC))
        
        viewControllers = [home.navigationController, setting.navigationController, message.navigationController]
    }
    

}
