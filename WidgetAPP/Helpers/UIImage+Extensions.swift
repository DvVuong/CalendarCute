//
//  UIImage+Extensions.swift
//  WidgetAPP
//
//  Created by MRX on 11/7/23.
//

import Foundation
import SwiftUI


extension UIImage {
    
     func converImageToBase64String() -> String {
        guard let imagData: NSData = self.jpegData(compressionQuality: 0.5) as NSData? else {return ""}
        let imgString = imagData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    
}

extension String {
    
    func converBase64ToImage() -> UIImage? {
        guard let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0)) else {return nil}
         let image = UIImage(data: imageData)
        return image
    }
}
