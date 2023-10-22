//
//  CalendarView.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var dateHolper: DateHolder
    @State private var isShowCreateView: Bool = false
    @State private var componenstType: ComponenstType = ComponenstType.Event
    
    let dayOfWeek: [String] = ["CN", "Th2", "Th3", "Th4", "Th5", "Th6", "Th7"]
    var currentDay: Date = .init()
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    DateScrollView()
                        .environmentObject(dateHolper)
                        .padding()
                    DayOfWeekStack()
                    CalendarGrid()
                    CurrentDateView()
                    ComponenstView(isShowCreateView: $isShowCreateView, componenstType: $componenstType)
                        .padding()
                }
            }
            .sheet(isPresented: $isShowCreateView, content: {
                CreateNewActionView(componenst: componenstType)
            })
        }
    @ViewBuilder
    func DayOfWeekStack() -> some View {
        HStack(spacing: 0) {
            ForEach(dayOfWeek, id: \.self) { item in
                Text(item)
                    .frame(width: 50, height: 45)
                    .padding(.bottom, 30)
                    .overlay(createBoderFrame())
            }
        }
    }
    
    @ViewBuilder
    func createBoderFrame() -> some View {
        RoundedRectangle(cornerRadius: 0).stroke(Color.orange)
    }
    
    @ViewBuilder
    func CalendarGrid() -> some View {
        VStack(spacing: 0) {
            let daysInMonth = CalendarHelper().dayinMonth(dateHolper.date)
            let firstDatOfMonth = CalendarHelper().firtOfMonth(dateHolper.date)
            let startingSpaces = CalendarHelper().weekDay(firstDatOfMonth)
            let prevMonth = CalendarHelper().perviousMonth(dateHolper.date)
            let daysInPrevMonth = CalendarHelper().dayinMonth(prevMonth)
            
            ForEach(0..<6) { row in
                HStack(spacing: 0) {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        CalendarCell(count: count,
                                     startingSpaces: startingSpaces,
                                     daysInMonth: daysInMonth,
                                     daysInPrevMonth: daysInPrevMonth)
                            .environmentObject(dateHolper)
                    }
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

struct CurrentDateView: View {
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "calendar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text(CalendarHelper().convertCurrentDayString(with: .full))
                .font(.system(size: 15))
                .bold()
                .padding()
            Spacer()
        }
        .padding()
    }
}
