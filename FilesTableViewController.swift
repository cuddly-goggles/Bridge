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
        fileBrowser = FileBrowser(initialPath: paths[0], allowEditing: true, showCancelButton: false)
        self.addChildViewController(fileBrowser!)
        self.view.addSubview((fileBrowser?.view)!)
        fileBrowser?.didMove(toParentViewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fileBrowser?.reload()
    }
}
