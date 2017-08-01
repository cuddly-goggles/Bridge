//
//  Version.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 8/1/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Version {
    
    var youtube_dl: String?
    var youtube_dl_api_server: Double?
    
    
    init(_ json: JSON?) {
        guard let json = json else {
            return
        }
        youtube_dl = json["youtube-dl"].string
        youtube_dl_api_server = json["youtube-dl-api-server"].double
    }
}
