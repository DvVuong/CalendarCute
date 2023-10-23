//
//  UserDefaultManager.swift
//  WidgetAPP
//
//  Created by MRX on 10/23/23.
//

import Foundation
import SwiftUI

class UserDefaultManager {
    static var shared = UserDefaultManager()
    private let COLOR_KEY = "COLOR_KEY"
    private let INDEX_KEY = "INDEX_KEY"
    private let userDefaults = UserDefaults.standard
    
    func saveColor(with color: Color) {
        let color = UIColor(color).cgColor
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY)
        }
    }
    
    func loadColor() -> Color {
        guard let array = userDefaults.object(forKey: COLOR_KEY) as? [Double] else {
            return Color.green
        }
        
        let color =  Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        return color
    }
    
    func saveIndexColor(with index: Int) {
        userDefaults.set(index, forKey: INDEX_KEY)
    }
    
    func loadIndexColor() -> Int {
       guard let index = userDefaults.object(forKey: INDEX_KEY) as? Int else {
            return 0
        }
        return index
    }
}
