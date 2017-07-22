//
//  Video.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/3/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import Foundation

struct Video {
    var title: String?
    var id: String?
    var formats: [Format]
}


struct Format {
    var format: String?
    var formatID: String?
    var ext: String?
    var url: String?
}
