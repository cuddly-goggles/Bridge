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
    init(json: JSON) {
        if let error = json["error"].string {
           errmsg = error
            errorOccured = true
        } else {
            if let formats = json["info"]["formats"].array {
                for format in formats {
                    let fm = Format(format: format["format"].string, formatID: format["format_id"].string, ext: format["ext"].string, url: format["url"].string)
                    self.formats.append(fm)
                }
            } else {
                self.formats.append(Format(format: json["format"].string, formatID: json["format_id"].string, ext: json["ext"].string, url: json["url"].string))
            }
            errmsg = ""
            errorOccured = false
        }
        
    }
    
}

