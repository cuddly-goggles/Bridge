//
//  FilesTableViewController.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/21/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import FileBrowser
import FileExplorer
class FilesViewController: UINavigationController {
    
    @IBAction func showFileManager(_ sender: Any) {
        //let fileExplorer = FileExplorerViewController()
        //self.present(fileExplorer, animated: true, completion: nil)
        //present(fileBrowser, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        
        let fileBrowser = FileBrowser(initialPath: documentsDirectory, allowEditing: true, showCancelButton: false)
        
        self.addChildViewController(fileBrowser)
        self.view.addSubview(fileBrowser.view)
        fileBrowser.didMove(toParentViewController: self)

        
    }
    


}
