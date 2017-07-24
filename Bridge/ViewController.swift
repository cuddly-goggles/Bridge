//
//  ViewController.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/2/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let youtubeDL = YouTube_dl()
        
        youtubeDL.run_server("")
    }
    
    @IBAction func btn(_ sender: Any) {
        print("hrlp")
    }
}


