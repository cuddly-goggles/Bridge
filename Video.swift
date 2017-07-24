//
//  Video.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/24/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Format {
    var format: String?
    var formatID: String?
    var ext: String?
    var url: String?
}



class Video {
    var formats: [Format] = []
    var errmsg: String
    var errorOccured: Bool
    var title: String?
    
    init(json: JSON) {
        if let error = json["error"].string {
            errmsg = error
            errorOccured = true
        } else {
            title = json["info"]["title"].string
            if let formats = json["info"]["formats"].array {
                for format in formats {
                    let fm = Format(format: format["format"].string, formatID: format["format_id"].string, ext: format["ext"].string, url: format["url"].string)
                    self.formats.append(fm)
                }
            } else {
                self.formats.append(Format(format: json["info"]["format"].string, formatID: json["info"]["format_id"].string, ext: json["info"]["ext"].string, url: json["info"]["url"].string))
            }
            
            errmsg = ""
            errorOccured = false
        }
        
    }
    
}

