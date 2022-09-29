//
//  Entity.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/9/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Format {
    var format: String
    var ext: String
    var url: String
    
    init(_ json: JSON) {
        format = json["format"].stringValue
        ext = json["ext"].stringValue
        url = json["url"].stringValue
    }
}

struct Entity {
    var title: String
    var formats: [Format] = []
    
    init(_ fms: JSON) {
        title = fms["title"].stringValue
        for fm in fms["formats"].arrayValue {
            formats.append(Format(fm))
        }
    }
    
}

struct Entires {
    
    var entries: [Entity] = []
    
    init(_ json: JSON) {
        
        if let entys = json["info"]["entries"].array {
            for entry in entys {
                entries.append(Entity(entry))
            }
        } else {
            entries.append(Entity(json["info"]))
        }
        
    }
    
}
