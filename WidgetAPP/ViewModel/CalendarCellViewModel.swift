//
//  CalendarCellViewModel.swift
//  WidgetAPP
//
//  Created by MRX on 10/24/23.
//

import Foundation
import SwiftUI
class CalendarCellViewModel: ObservableObject {
    init() {}
    
    func monthStruct(with count: Int, startingSpaces: Int, daysInMonth: Int, daysInPrevMonth: Int) -> MonthStruct {
       let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if count <= start {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: .Previous, dayInt: day)
        }else if count - start > daysInMonth {
            let day = count - start - daysInMonth
            
            return MonthStruct(monthType: .Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: .Current, dayInt: day)
    }
    
}
