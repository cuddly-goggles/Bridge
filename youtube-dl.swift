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
        
        youtubeDL.exctract(url) { (rawJson) in
            let json = JSON(data: (rawJson?.data(using: String.Encoding.utf8))!)
            debugPrint(json)
            var requestedVideo = Video(title: json["title"].string, id: json["id"].string, formats: [])
            if let formats = json["formats"].array {
                for format in formats {
                    let fm = Format(format: format["format"].string, formatID: format["format_id"].string, ext: format["ext"].string, url: format["url"].string)
                    requestedVideo.formats.append(fm)
                }

            } else {
                requestedVideo.formats.append(Format(format: json["format"].string, formatID: json["format_id"].string, ext: json["ext"].string, url: json["url"].string))
            }
            completion(requestedVideo)
            
        }
        
    }
}
