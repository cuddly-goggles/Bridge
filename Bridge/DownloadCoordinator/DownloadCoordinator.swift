//
//  DownloadCoordinator.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/7/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//


import UIKit


class DownloadCoordinator: Coordinator {
    private var navViewcontroler: UINavigationController
    private var downloadViewController: DownloadViewController
    
    public var rootViewController: UIViewController {
        return navViewcontroler
    }
    public var downloadDelegate: DownloadViewController {
        return downloadViewController
    }
    
    init() {
        navViewcontroler = UINavigationController()
        downloadViewController = DownloadViewController(nibName: nil, bundle: nil) // 6
        downloadViewController.title = "Download"
        navViewcontroler.pushViewController(downloadViewController, animated: true)
        
    }
    
    func start() {
    }
}
