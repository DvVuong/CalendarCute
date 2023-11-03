//
//  CalendarCell.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolper: DateHolder
    @EnvironmentObject var coreDta: CoreDataManager
    @State var customColor: Color = .yellow
    @State private var monthStruct: MonthStruct = .init(monthType: .Current, dayInt: 0)
    private let viewModel: CalendarCellViewModel = CalendarCellViewModel()
    
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
                Text(monthStruct.day)
                    .font(.system(size: 15))
                    .foregroundColor(textColor(type: monthStruct.monthType))
                    .frame(width: 50, height: 10)
                    .padding(.leading, -25)
                    .padding(.top, 8)
                ScrollView(showsIndicators: false) {
                    ForEach(coreDta.todoArrays) { task in
                        if checkDayCreate(with: task) {
                            componenstView(with: task)
                        }
                    }
                }
                Spacer()
            }
            Spacer()
            Button(action: {
            }, label: {
                if textColor(type: monthStruct.monthType) == .black {
                    NavigationLink(destination: TaskView(dayOfMonth: monthStruct.day)
                                    .navigationBarHidden(true),
                                   label: {
                                    Rectangle()
                                        .frame(maxWidth: 50, maxHeight: 150)
                                        .foregroundColor(.clear)
                                   })
                }
            })
            .frame(maxWidth: 50, maxHeight: .infinity)
            .background(Color.clear)
        }
        .frame(width: 50, height: 150)
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.orange))
        .onAppear {
            monthStruct = viewModel.monthStruct(with: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
        }
    }
    
    @ViewBuilder
    func componenstView(with task: ToDoEntity) -> some View {
        let title = task.taskTitle?.getFourOfString()
        let color = Color(.sRGB, red: task.red , green: task.green , blue: task.blue, opacity: task.alpha)
        ZStack {
            Rectangle()
                .frame(maxWidth: 45, maxHeight: 20)
                .foregroundColor(color)
                .cornerRadius(4)
            VStack {
                Text(title ?? "")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
            }
        }
    }
    
    @ViewBuilder
    func setBackgroundImage(with nameImage: String) -> some View {
        Image(nameImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 650, height: 120)
            .padding()
    }
    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? .black : .green
    }
    
    func checkDayCreate(with task: ToDoEntity) -> Bool {
        guard let date = task.creationDate else {return false}
        let createDate = CalendarHelper().dayOfMonth(date)
        let createNameMonth = CalendarHelper().monthYearString(date)
        if createNameMonth == CalendarHelper().monthYearString(dateHolper.date) && String(createDate) == monthStruct.day && textColor(type: monthStruct.monthType) == .black {
            return true
        }else {
            return false
        }
    }
    
    func setbackgroundColor() -> Color {
        let currentDay = CalendarHelper().dayOfMonth(Date())
        let currenMonth = CalendarHelper().currentMonth(Date())
        let nameOfMonth = CalendarHelper().nameOfNextMonth(dateHolper.date)
        
        if currenMonth == nameOfMonth && String(currentDay) == monthStruct.day && textColor(type: monthStruct.monthType) == .black {
            return Color.green.opacity(0.35)
        }else {
            return Color.white
        }
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(count: 1,
                     startingSpaces: 1,
                     daysInMonth: 1,
                     daysInPrevMonth: 1)
    }
}
