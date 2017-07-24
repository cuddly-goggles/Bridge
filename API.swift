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

class API {
    static let shared = API()
    
    
    let BASEURL: String = "http://127.0.0.1:5000"
    
    
    func info(_ url: String, completion: @escaping (Video) -> ()) {
        let parameters: Parameters = ["url": url, "flatten": "False"]
        
        Alamofire.request(BASEURL + "/api/info", method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                debugPrint(json)
                completion(Video(json: json))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
