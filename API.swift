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
    var youtube_dl: ObjcFlask?
    
    func initobject() {
        youtube_dl = ObjcFlask()
    }
    
    func info(_ url: String, completion: @escaping (Entries?, Bool) -> ()) {
        DispatchQueue.global().async {
            guard let response = self.youtube_dl?.excreact_info(url) else {return}
            if let dataFromString = response.data(using: .utf8, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                switch json["is_error"].boolValue {
                case true:
                    RMessage.showNotification(withTitle: "Error", subtitle: json["error_msg"].stringValue, type: .error, customTypeName: nil, callback: nil)
                    completion(nil, true)
                case false:
                    guard let data = json["data"].string?.data(using: .utf8, allowLossyConversion: false) else { return }
                    completion(Entries(JSON(data: data)), false)
                }
            }
        }
    }
}
        /*Alamofire.request(BASEURL + "/api/info", method: .get, parameters: parameters).responseJSON { (response) in
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
    }*/
    

