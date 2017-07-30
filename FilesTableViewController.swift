//
//  FilesTableViewController.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/21/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import FileBrowser
class FilesViewController: UINavigationController {
    
    var fileBrowser: FileBrowser?
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initfilebrowser()
        self.addChildViewController(fileBrowser!)
        addfilebroswerview()
        fileBrowser?.didMove(toParentViewController: self)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if fileBrowser == nil {
            initfilebrowser()
            addfilebroswerview()
        }
    }
    
    func initfilebrowser() {
        //fileBrowser = FileBrowser(initialPath: paths[0])
        fileBrowser = FileBrowser(initialPath: paths[0], allowEditing: true, showCancelButton: false)
        
    }
    
    func addfilebroswerview() {
        //fileBrowser?.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - (self.tabBarController?.tabBar.frame.height)!)
        self.view.addSubview((fileBrowser?.view)!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        fileBrowser?.view.removeFromSuperview()
        fileBrowser = nil
        
        /*let vc = self.childViewControllers.last
        vc?.willMove(toParentViewController: nil)
        vc?.view.removeFromSuperview()
        vc?.removeFromParentViewController()
        */
        
    }
    


}
