//
//  ExtensionCalendarHelper.swift
//  WidgetAPP
//
//  Created by MRX on 10/25/23.
//

import SwiftUI

class MyCalendar {
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func fetchMonth(with date: Date) -> [MonthDays] {
        var monthArrys: [MonthDays] = []
        let dateComponset = DateComponents(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date))

        let dateRange = calendar.date(from: dateComponset) ?? Date()
        guard let range = calendar.range(of: .day, in: .month, for: dateRange) else {
            return []
            
        }
        let numDays = range.count
        
       
        let starOfDate = calendar.startOfDay(for: date)
        
        
        let weekForDate = calendar.dateInterval(of: .month, for: starOfDate)
        guard let startOfWeek = weekForDate?.start else {
            return []
        }
        
        //Interating to get the full Week
        (0..<numDays).forEach { (index) in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                monthArrys.append(.init(date: weekDay))
            }
        }
        return monthArrys
    }
}

struct MonthDays: Identifiable {
    var id: UUID = UUID()
    var date: Date
}
