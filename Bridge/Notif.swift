//
//  Notif.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 7/22/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

import UIKit
import UserNotifications

class Notif: NSObject {
    static let shared = Notif()
    
    let center: UNUserNotificationCenter
    let options: UNAuthorizationOptions
    
    override init() {
        center = UNUserNotificationCenter.current()
        options = [.alert, .sound];
    }
    
    func requestgrant() {
        self.center.requestAuthorization(options: self.options) {
            (granted, error) in
            if !granted {
                debugPrint("Something went wrong")
            }
        }
    }
    
    func downloadComplete(_ fileName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Download Complete"
        content.body = "Download \(fileName) finished."
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                debugPrint(error)
            }
        })

    }
}
