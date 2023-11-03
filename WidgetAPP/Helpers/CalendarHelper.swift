//
//  CalendarHelper.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import Foundation

class CalendarHelper {
    
     let calender = Calendar.current
     let dateFormatter = DateFormatter()
    
    /// Convert Date to String
    func monthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL yyy"
        return dateFormatter.string(from: date)
    }
    
    /// Next Month
    func plusMonth(_ date: Date) -> Date {
        return calender.date(byAdding: .month, value: 1, to: date) ?? Date()
    }
    
    /// Previous Month
    func perviousMonth(_ date: Date) -> Date {
        return calender.date(byAdding: .month, value: -1, to: date) ?? Date()
    }
    
    /// Current date
    func convertCurrentDayString(with style: DateFormatter.Style) -> String {
        let currentDay = Date()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: currentDay)
    }
    
    /// Get current time
    func currentTimeString(with formatter: String) -> String {
        let currentDay = Date()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: currentDay)
    }
    
    /// Name of  month
    func nameOfNextMonth(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }

    /// Current Month
    func currentMonth(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }
    
    /// Day in Month
    func dayinMonth(_ date: Date) -> Int {
        let range = calender.range(of: .day, in: .month, for: date)
        return range?.count ?? 1
    }
    
    /// Day of Month
    func dayOfMonth(_ date: Date) -> Int {
        let components = calender.dateComponents([.day], from: date)
        return components.day ?? 1
    }
    
    /// Firt Of Month
    func firtOfMonth(_ date: Date) -> Date {
        let components = calender.dateComponents([.year, .month], from: date)
        return calender.date(from: components) ?? Date()
    }
    
    /// WeekDay
    func weekDay(_ date: Date) -> Int {
        let components = calender.dateComponents([.weekday], from: date)
        return (components.weekday ?? 1) - 1
    }
    /// Day in Weekday
    func dayInWeekDay(_ date: Date) -> Int {
        let day = calender.dateComponents([.weekday], from: date)
        return day.day ?? 1
    }
    
    func getDayOfMonthForInt(with day: Int, month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let date = calender.date(from: dateComponents)
        return date ?? Date()
    }
    
    func convertNameMonthToInt(with nameMonth: String) -> Int? {
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "LLL"
        if let date = dateFormatter.date(from: nameMonth) {
            let month = calender.component(.month, from: date)
            return month
        }
        return nil
    }
    
}
