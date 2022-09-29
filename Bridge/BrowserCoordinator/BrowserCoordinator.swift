//
//  BrowserCoordinator.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/9/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import Foundation
import FileBrowser

class BrowserCoordinator: Coordinator {
    //private let presenter: UITabBarController
    //private var navViewcontroler: BrowserViewController
    //let browserViewController: BrowserViewController

    var fileBrowser: FileBrowser?
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    public var rootViewController: UIViewController {
        return fileBrowser!
    }
    
    
    init() {
        //browserViewController = BrowserViewController(nibName: nil, bundle: nil)
        fileBrowser = FileBrowser(initialPath: paths[0], allowEditing: true, showCancelButton: false)
        
        //navViewcontroler.title = "Browser"
        //navViewcontroler.pushViewController(browserViewController, animated: true)
        
    }
    
    func start() {
    }
}
