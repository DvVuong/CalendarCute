//
//  WidgetAPPApp.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

@main
struct WidgetAPPApp: App {
    
    var body: some Scene {
        WindowGroup {
            let dateHodel = DateHolder()
//            let taskItem = TaskItem(id: UUID(), taskType: .Todo,
//                                    taskTitle: "",
//                                    taskDescription: "",
//                                    creationDate: Date(),
//                                    endDate: Date(),
//                                    tint: .white,
//                                    isAllDay: false,
//                                    isSetReminder: false,
//                                    alertBefore: Date(),
//                                    isCompelete: false)
            ContentView()
                .environmentObject(dateHodel)
                //.environmentObject(taskItem)
        }
    }
}
