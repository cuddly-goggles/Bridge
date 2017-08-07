//
//  File.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/29/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import Foundation
import RMessage
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
        RMessage.showNotification(withTitle: "Server Initialization", subtitle: "Initializing Server please wait a moment", type: .warning, customTypeName: nil, callback: nil)
        //objcServer.run_server(9191)
        serverState = .assignedTorun
        
    }
    
}
