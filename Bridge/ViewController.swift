//
//  ViewController.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/2/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    
    let yd = SwiftyDL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yd.extract(url: "https://www.youtube.com/watch?v=d-VOPvny-O0") { (videos) in
            for i in videos.formats {
                print(i.ext)
            }
        }
    
    }
    
    @IBAction func btn(_ sender: Any) {
        print("hrlp")
    }
}


