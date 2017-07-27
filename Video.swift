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



struct Video {
    var formats: [Format] = []
    var title: String?
    
    init(formats: [JSON], title: String?) {
        self.title = title
        for format in formats {
            let fm = Format(format: format["format"].string, formatID: format["format_id"].string, ext: format["ext"].string, url: format["url"].string)
            self.formats.append(fm)
        }

    }
    
    init(format: Format, title: String?) {
        self.title = title
        self.formats.append(format)
    }
}





class Entries {
    
    var errmsg: String
    var errorOccured: Bool
    var title: String?
    var videos: [Video] = []
    
    init(json: JSON) {
        if let error = json["error"].string {
            errmsg = error
            errorOccured = true
        } else {
            title = json["info"]["title"].string
            if let entries = json["info"]["entries"].array {
                for entrie in entries {
                    guard let formats = entrie["formats"].array else {
                        errmsg = ""
                        errorOccured = true
                        return
                    }
                    let video = Video(formats: formats, title: entrie["title"].string)
                    videos.append(video)
                }
            } else {
                if let formats = json["info"]["formats"].array {
                    let video = Video(formats: formats, title: json["info"]["title"].string)
                    videos.append(video)
                } else {
                    let video = Video(format: Format(format: json["info"]["format"].string, formatID: json["info"]["format_id"].string, ext: json["info"]["ext"].string, url: json["info"]["url"].string), title: json["info"]["title"].string)
                    videos.append(video)
                    
                }
            }
        }
        errmsg = ""
        errorOccured = false
    }
}


