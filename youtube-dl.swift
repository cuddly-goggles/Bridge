//
//  youtube-dl.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/3/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit


class SwiftyFlask {
    static let shared = SwiftyFlask()
    
    func run_server() {
        let youtubeDL = YouTube_dl()
        youtubeDL.run_server("")
        
    }
}
