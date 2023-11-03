//
//  UIColorTransformer.swift
//  WidgetAPP
//
//  Created by MRX on 11/3/23.
//

import Foundation
import UIKit
import SwiftUI

@objc(UIColorTransformer)
class UIColorTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: UIColorTransformer.self))

//    override static var allowedTopLevelClasses: [AnyClass] {
//            return [NSArray.self, UIColor.self]
//        }
//
//    public static func register() {
//            let transformer = UIColorTransformer()
//            ValueTransformer.setValueTransformer(transformer, forName: name)
//        }
    
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else {return nil}
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            print("vuongdv Data! \(data)")
            return data
        }
        catch let error {
            print("vuongdv error Transformer!. \(error.localizedDescription)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else {return nil}
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data as Data)
            print("vuongdv color! \(color)")
            return color
        }
        catch let error {
            print("vuongdv error reverseTransformedValue!. \(error.localizedDescription)")
            return nil
        }
    }
    
   
}
