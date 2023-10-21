//
//  MonthStruct.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import Foundation

struct MonthStruct {
    var monthType: MonthType
    var dayInt: Int
    var day: String {
        return String(dayInt)
    }
}

enum MonthType {
    case Previous
    case Current
    case Next
}
