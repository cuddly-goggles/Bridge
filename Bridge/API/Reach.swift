//
//  Reach.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 4/27/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    
    func waitforServer() {
        let myqueue = DispatchQueue(label: "waitforsercer")
        myqueue.async {
            while true {
                let task = URLSession.shared.synchronousDataTask(with: URL(string: "http://127.0.0.1:9191/api/version")!)
                if task.1 != nil {
                    DispatchQueue.main.async {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                    break
                }
                sleep(UInt32(0.5))
            }
        }
    }
    
    func isServerUp() -> Bool {
        let task = URLSession.shared.synchronousDataTask(with: URL(string: "http://127.0.0.1:9191/api/version")!)
        if task.1 != nil {
            return true
        } else {
            return false
        }
    }
}
