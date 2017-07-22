//
//  FilesTableViewController.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/21/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import FileBrowser

class FilesViewController: UIViewController {
    
    @IBAction func showFileManager(_ sender: Any) {
        //let fileExplorer = FileExplorerViewController()
        //self.present(fileExplorer, animated: true, completion: nil)
        let fileBrowser = FileBrowser()
        present(fileBrowser, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    


}
