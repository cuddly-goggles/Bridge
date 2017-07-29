//
//  API.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/24/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RMessage
class API {
    static let shared = API()
    
    
    let BASEURL: String = "http://127.0.0.1:9191"
    
    
    func info(_ url: String, completion: @escaping (Entries?, Bool) -> ()) {
        let parameters: Parameters = ["url": url, "flatten": "False"]
        
        Alamofire.request(BASEURL + "/api/info", method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                switch response.response!.statusCode {
                case 200:
                    let json = JSON(response.result.value!)
                    //debugPrint(json)
                    completion(Entries(json: json), true)
                case 400:
                    RMessage.showNotification(withTitle: "400 Bad Request", subtitle: "Invalid query parameters", type: .error, customTypeName: nil, callback: nil)
                    completion(nil, false)
                case 500:
                    RMessage.showNotification(withTitle: "500 Internal Server Error", subtitle: "The extraction fails, Please check your URL or Your Internet service provider might have blocked access to specific websites e.g YouTube, Blogger", type: .error, customTypeName: nil, duration: 8, callback: nil)
                    completion(nil, false)
                default:
                    completion(nil, false)
                    NSLog("Default")
                }
            case .failure(let error):
                RMessage.showNotification(withTitle: "Error", subtitle: error.localizedDescription, type: .error, customTypeName: nil, callback: nil)
                completion(nil, false)
            }
        }
    }
    
    func isServerup(completion: @escaping (Bool) -> ()) {
        
        Alamofire.request(BASEURL+"/api/version").responseJSON { (response) in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
}
