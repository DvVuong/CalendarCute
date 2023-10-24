//
//  CalendarCellViewModel.swift
//  WidgetAPP
//
//  Created by MRX on 10/24/23.
//

import Foundation

class CalendarCellViewModel {
    var array: [TaskItem] = [
        TaskItem(id: UUID(),taskType: .Todo,taskTitle: "1",taskDescription: "description",creationDate: Date(),endDate: Date(),tint: .green,isAllDay: true,isSetReminder: true,alertBefore: Date(),isCompelete: true),
        TaskItem(id: UUID(),taskType: .Todo,taskTitle: "2",taskDescription: "description",creationDate: Date(),endDate: Date(),tint: .red,isAllDay: true,isSetReminder: true,alertBefore: Date(),isCompelete: true),
        TaskItem(id: UUID(),taskType: .Todo,taskTitle: "3",taskDescription: "description",creationDate: Date(),endDate: Date(),tint: .yellow,isAllDay: true,isSetReminder: true,alertBefore: Date(),isCompelete: true)
//        TaskItem(id: UUID(),taskType: .Todo,taskTitle: "4",taskDescription: "description",creationDate: Date(),endDate: Date(),tint: .orange,isAllDay: true,isSetReminder: true,alertBefore: Date(),isCompelete: true),
//        TaskItem(id: UUID(),taskType: .Todo,taskTitle: "5",taskDescription: "description",creationDate: Date(),endDate: Date(),tint: .pink,isAllDay: true,isSetReminder: true,alertBefore: Date(),isCompelete: true),
//        TaskItem(id: UUID(),taskType: .Todo,taskTitle: "6",taskDescription: "description",creationDate: Date(),endDate: Date(),tint: .purple,isAllDay: true,isSetReminder: true,alertBefore: Date(),isCompelete: true)
    ]
    
    var limetedItem: [TaskItem] = []
    
    init() {
        if array.count > 4 {
            limetedItem = Array(array.prefix(4))
        }else {
            limetedItem = array
        }
    }
    
    
}
