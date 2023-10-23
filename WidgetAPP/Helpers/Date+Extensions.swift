//
//  Date+Extensions.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

/// extension date for binding to view
extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func formatter() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: self)
    }
    /// Formatter String
    
    func formatterDateStyle(with style: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = style
        return formatter.string(from: self)
    }
    
    /// Checking Whether the Date is Today
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Fetching Week Based on given Date
    func fetchWeek(_ date: Date = .init()) -> [Weekdays] {
        let calendar = Calendar.current
        let starOfDate = calendar.startOfDay(for: date)
        
        var week: [Weekdays] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: starOfDate)
        guard let startOfWeek = weekForDate?.start else {
            return []
        }
        
        //Interating to get the full Week
        (0..<7).forEach { (index) in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: weekDay))
            }
        }
        return week
    }
    
    /// Creating Next Week, based on the Last Current Week's Date
    func creatWeekNext() -> [Weekdays] {
        let calendar = Calendar.current
        let starrOflastDate = calendar.startOfDay(for: self)
        guard let nextDate  = calendar.date(byAdding: .day, value: 1 ,to: starrOflastDate) else {
            return []
        }
        
        return fetchWeek(nextDate)
    }
    /// Creating Previous  Week, based on the Last Current Week's Date
    func creatpreviousWeekNext() -> [Weekdays] {
        let calendar = Calendar.current
        let starrOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate  = calendar.date(byAdding: .day, value: -1 ,to: starrOfFirstDate) else {
            return []
        }
        
        return fetchWeek(previousDate)
    }
    
    
    struct Weekdays: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
