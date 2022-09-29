//
//  roundTo.swift
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/9/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

import UIKit

extension Float {
    
    /// Rounds the value to the nearest with precision count.
    ///
    /// Usage:
    ///
    ///     3.00.roundTo(2)   // 3
    ///     3.035.roundTo(2)  // 3.04
    ///     3.05.roundTo(1)   // 3.1
    ///     3.999.roundTo(3)  // 3.999
    ///
    ///     -3.00.ceilTo(2)   // -3
    ///     -3.035.ceilTo(2)  // -3.04
    ///     -3.05.ceilTo(1)   // -3.1
    ///     -3.999.ceilTo(3)  // -3.999
    ///
    public mutating func roundTo() -> String {
        
        return String(format: "%.1f", self)
    }
   
    
}


