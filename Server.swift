//
//  File.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/29/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import Foundation

enum ServerState {
    case running
    case assignedTorun
    case notInitialized
}

struct Server {
    
    static var shared = Server()
    var serverState: ServerState
    private var objcServer: ObjcFlask
    
    init() {
        objcServer = ObjcFlask()
        serverState = .notInitialized
    }
    mutating func runserver() {
        objcServer.run_server(9191)
        serverState = .assignedTorun
        
    }
    
}
