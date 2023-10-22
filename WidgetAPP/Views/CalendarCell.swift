//
//  CalendarCell.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolper: DateHolder
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    var body: some View {
        VStack {
            ZStack {
                Button(action: {
                }, label: {
                    NavigationLink(
                        destination: Text(monthStruct().day),
                        label: {
                            Text("                                                                                                     ")
                                .background(Color.clear)
                        })
                })
                .padding()
                .frame(maxWidth: 50, maxHeight: .infinity)
                .background(setbackgroundColor())
                
                VStack {
                    Text(monthStruct().day)
                        .foregroundColor(textColor(type: monthStruct().monthType))
                        .frame(width: 50, height: 10)
                        .padding(.leading, -20)
                        .padding(.top, 10)
                    Spacer()
                }
            }
            .frame(width: 50, height: 100)
        }
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.orange))
    }
    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? .black : .green
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
        let currentDay = CalendarHelper().dayOfMonth(dateHolper.date)
        let currenMonth = CalendarHelper().currentMonth(Date())
        let nameOfMonth = CalendarHelper().nameOfNextMonth(dateHolper.date)
        if (currenMonth == nameOfMonth) && (String(currentDay) == monthStruct().day) {
            return Color.green
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
