//
//  Extension.swift
//  WidgetAPP
//
//  Created by MRX on 10/24/23.
//

import Foundation
import SwiftUI

extension String {
    func getFourOfString() -> String {
        if self.count > 4 {
            let str = self.index(self.startIndex, offsetBy: 4)
            return String(self.prefix(upTo: str))
        }else {
            return self
        }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
