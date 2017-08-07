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
    var title: String?
    var videos: [Video] = []
    
    init(_ json: JSON) {
        title = json["title"].string
        if let entries = json["entries"].array {
            
            for entrie in entries {
                guard let formats = entrie["formats"].array else {
                    return
                }
                let video = Video(formats: formats, title: entrie["title"].string)
                videos.append(video)
            }
        } else {
            if let formats = json["formats"].array {
                
                let video = Video(formats: formats, title: json["title"].string)
                videos.append(video)
            } else {
                let video = Video(format: Format(format: json["format"].string, formatID: json["format_id"].string, ext: json["ext"].string, url: json["url"].string), title: json["title"].string)
                videos.append(video)
                
            }
        }
    }
}


