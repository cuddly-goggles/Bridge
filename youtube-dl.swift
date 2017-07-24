//
//  youtube-dl.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/3/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import SwiftyJSON

class SwiftyDL {
    
    func extract(url: String, completion: @escaping (Video) -> ()) {
        let youtubeDL = YouTube_dl()
        
        youtubeDL.run_server("")
        
    }
}
