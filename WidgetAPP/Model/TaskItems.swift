//
//  TaskItems.swift
//  WidgetAPP
//
//  Created by MRX on 10/25/23.
//

import Foundation
import SwiftUI

class TaskItems: ObservableObject {
    @Published var list: [TaskItem] = []
    var limetedItem: [TaskItem] = []
    
    init() {}
    
    func getLimetedItem() -> [TaskItem] {
        if list.count > 4 {
            limetedItem = Array(list.prefix(4))
            print("vuongdv limetedItem1", limetedItem.count)
            return limetedItem
        }else {
            limetedItem = list
            print("vuongdv limetedItem2", limetedItem.count)
            return limetedItem
        }
    }
    
}
