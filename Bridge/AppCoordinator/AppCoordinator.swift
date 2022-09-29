//
//  AppCoordinator.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/7/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UITabBarController
    let searchCoordinator: SearchCoordinator
    let downloadCoordinator: DownloadCoordinator
    let browserCoordinator:BrowserCoordinator
    var controllers: [UIViewController]
    
    init(window: UIWindow) {
        self.window = window
        
        rootViewController = UITabBarController()
        searchCoordinator = SearchCoordinator()
        downloadCoordinator = DownloadCoordinator()
        browserCoordinator = BrowserCoordinator()
        controllers = []
        
        
        let searchViewController = searchCoordinator.rootViewController
        searchViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "feed"), selectedImage: nil)
        searchCoordinator.searchViewController.downloadManager = downloadCoordinator.downloadDelegate.downloadManager
       
        let downloadViewController = downloadCoordinator.rootViewController
        downloadViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "download"), selectedImage: nil)
        
        let browserViewController = browserCoordinator.rootViewController
        browserViewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "file"), selectedImage: nil)
        
        controllers.append(searchViewController)
        controllers.append(downloadViewController)
        controllers.append(browserViewController)
        
        rootViewController.tabBar.unselectedItemTintColor = UIColor(red:0.66, green:0.66, blue:0.66, alpha:1.0)
        for controller in controllers {
            controller.tabBarItem?.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
        rootViewController.viewControllers = controllers
        rootViewController.tabBar.isTranslucent = false

        
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
