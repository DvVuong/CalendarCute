//
//  TintModel.swift
//  WidgetAPP
//
//  Created by MRX on 11/2/23.
//

import Foundation
import SwiftUI

struct TintColor {
    static var shared = TintColor()
    var alpha: Double?
    var red: Double?
    var green: Double?
    var blue: Double?
    
    init() {}
    
    mutating func setUpColor(with color: Color) -> TintColor {
        if let components = UIColor(color).cgColor.components {
            self.red = Double(components[0])
            self.green = Double(components[1])
            self.blue = Double(components[2])
            self.alpha = Double(components[3])
            
            
        }
        return self
    }
}
