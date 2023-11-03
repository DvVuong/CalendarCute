//
//  CoreDataManager.swift
//  WidgetAPP
//
//  Created by MRX on 10/27/23.
//

import CoreData
import SwiftUI

class CoreDataManager: ObservableObject {
    static var shared = CoreDataManager()
    @Published var todoArrays: [ToDoEntity] = []
    @Published var limitedDatas: [ToDoEntity] = []
    
    let container: NSPersistentContainer
    init() {
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName(rawValue: ""))
        
        container = NSPersistentContainer(name: "DataManager")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("vuongdv Error when Load CoreData",error)
            }else {
                print("vuongdv Susscess Load CoreData")
            }
        }
        fetchDataFromToDoEntities()
    }
    
    func fetchDataFromToDoEntities() {
        let request = NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
        do {
            todoArrays = try container.viewContext.fetch(request)
        }
        catch let error {
            print("vuongdv Error", error.localizedDescription)
        }
    }
    
    func addDataToTodoEntities(with taskItem: TaskItem) {
        let newToDoItems = ToDoEntity(context: container.viewContext)
        newToDoItems.id = taskItem.id
        newToDoItems.creationDate = taskItem.creationDate
        newToDoItems.endDate = taskItem.endDate
        newToDoItems.taskTitle = taskItem.taskTitle
        newToDoItems.taskDescription = taskItem.taskDescription
        newToDoItems.isAllDay = taskItem.isAllDay
        newToDoItems.taskType = taskItem.taskType.rawValue
        newToDoItems.red = taskItem.tint.red ?? 0
        newToDoItems.green = taskItem.tint.green ?? 0
        newToDoItems.blue = taskItem.tint.blue ?? 0
        newToDoItems.alpha = taskItem.tint.alpha ?? 0
        save()
    }
    
    func updateItem(with task: ToDoEntity) {
        for i in todoArrays {
            if i.id == (task.id ?? UUID()) {
                i.taskTitle = task.taskTitle
                i.taskDescription = task.taskDescription
            }else {
                return
            }
        }
        save()
    }
    
    func deleteTask(with index: Int) {
        let object = todoArrays[index]
        container.viewContext.delete(object)
        save()
    }
    
    func save() {
        do {
            try container.viewContext.save()
            print("vuongdv Success save Data to CoreData")
        }
        
        catch let error {
            print("vuongdv Error When Save Dato to CoreData", error.localizedDescription)
        }
    }
}
