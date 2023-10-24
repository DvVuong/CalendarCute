//
//  CalendarCell.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolper: DateHolder
    @EnvironmentObject var taskItem: TaskItem
    
    var arrasy: [TaskItem]
    let viewModel: CalendarCellViewModel = CalendarCellViewModel()
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: 50, maxHeight: .infinity)
                .foregroundColor(setbackgroundColor())
            
            VStack(spacing: 8) {
                Text(monthStruct().day)
                    .font(.system(size: 15))
                    .foregroundColor(textColor(type: monthStruct().monthType))
                    .frame(width: 50, height: 10)
                    .padding(.leading, -25)
                    .padding(.top, 8)
                
                ForEach(viewModel.limetedItem) { task in
                    if checkDayCreate(with: task.creationDate) {
                        componenstView(with: task)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
            Button(action: {
            }, label: {
                NavigationLink(
                    destination: Text(monthStruct().day),
                    label: {
                        Text("                                                                                                     ")
                            .background(Color.clear)
                    })
            })
            .frame(maxWidth: 50, maxHeight: .infinity)
            .background(Color.clear)
            
            Spacer()
            
        }
        .frame(width: 50, height: 150)
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.orange))
        
    }
    
    @ViewBuilder
    func componenstView(with task: TaskItem) -> some View {
        let title = task.taskTitle.getFourOfString()
        ZStack {
            Rectangle()
                .frame(maxWidth: 45, maxHeight: 20)
                .foregroundColor(task.tint)
                .cornerRadius(4)
            VStack {
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
            }
        }
    }
    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? .black : .green
    }
    
    func checkDayCreate(with date: Date) -> Bool {
        let createDate = CalendarHelper().dayOfMonth(date)
        if createDate == Int(monthStruct().day) && textColor(type: monthStruct().monthType) == .black {
            return true
        }else {
            return false
        }
    }
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if count < start {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: .Previous, dayInt: day)
        }else if count - start > daysInMonth {
            let day = count - start - daysInMonth
            
            return MonthStruct(monthType: .Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: .Current, dayInt: day)
    }
    
    func setbackgroundColor() -> Color {
        let currentDay = CalendarHelper().dayOfMonth(Date())
        let currenMonth = CalendarHelper().currentMonth(Date())
        let nameOfMonth = CalendarHelper().nameOfNextMonth(dateHolper.date)
        
        if currenMonth == nameOfMonth && String(currentDay) == monthStruct().day && textColor(type: monthStruct().monthType) == .black {
            return Color.green.opacity(0.35)
        }else {
            return Color.white
        }
    }
    
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(arrasy: [], count: 1,
                     startingSpaces: 1,
                     daysInMonth: 1,
                     daysInPrevMonth: 1)
    }
}
