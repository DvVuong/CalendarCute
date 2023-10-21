//
//  TaskItem.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import Foundation
import SwiftUI

struct TaskItem: Identifiable {
    var id: UUID = .init()
    var taskTitle: String
    var creationDate: Date = .init()
    var isCompelete: Bool = false
    var tint: Color
}

var tasl: [TaskItem] = [
    .init(taskTitle: "Record Video", creationDate: .updateHour(-5), isCompelete: false, tint: Color.yellow),
    .init(taskTitle: "Redesgin Website", creationDate: .updateHour(-3), isCompelete: false, tint: Color.green),
    .init(taskTitle: "Go for a walk", creationDate: .updateHour(-4), isCompelete: false, tint: Color.gray),
    .init(taskTitle: "Edit Video", creationDate: .updateHour(-2), isCompelete: false, tint: Color.black),
    .init(taskTitle: "Publish Video", creationDate: .updateHour(-1), isCompelete: false, tint: Color.blue),
    .init(taskTitle: "Tweet abount new Video!", creationDate: .updateHour(-0), isCompelete: false, tint: Color.pink)
]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
