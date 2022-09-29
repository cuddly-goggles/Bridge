//
//  SearchCoordinator.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/7/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import UIKit


class SearchCoordinator: Coordinator {
    //private let presenter: UITabBarController
    private var navViewcontroler: UINavigationController
    var searchViewController: SearchViewController
    
    public var rootViewController: UIViewController {
        return navViewcontroler
    }
    
    
    init() {
        navViewcontroler = UINavigationController()
        searchViewController = SearchViewController(nibName: nil, bundle: nil)
        searchViewController.title = "Search"
        navViewcontroler.pushViewController(searchViewController, animated: true)
        
    }
    
    func start() {
    }
}
