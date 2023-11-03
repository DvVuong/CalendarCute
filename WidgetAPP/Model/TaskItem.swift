//
//  TaskItem.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import Foundation
import SwiftUI

class TaskItem: ObservableObject, Identifiable {
    @Published var id: UUID = UUID()
    @Published var taskType: ComponenstType
    @Published var taskTitle: String
    @Published var taskDescription: String
    @Published var creationDate: Date
    @Published var endDate: Date
    @Published var isCompelete: Bool = false
    @Published var tint: TintColor
    @Published var isAllDay: Bool
    @Published var isSetReminder: Bool
    @Published var alertBefore: Date
   
    
    init(id: UUID, taskType: ComponenstType, taskTitle: String, taskDescription: String, creationDate: Date, endDate: Date, tint: TintColor, isAllDay: Bool, isSetReminder: Bool, alertBefore: Date, isCompelete: Bool) {
        self.id = id
        self.taskType = taskType
        self.taskDescription = taskDescription
        self.creationDate = creationDate
        self.endDate = endDate
        self.isCompelete = isCompelete
        self.tint = tint
        self.isAllDay = isAllDay
        self.alertBefore = alertBefore
        self.taskTitle = taskTitle
        self.isSetReminder = isSetReminder
    }
}

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
