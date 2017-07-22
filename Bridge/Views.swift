//
//  Views.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/3/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//





extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
    
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
