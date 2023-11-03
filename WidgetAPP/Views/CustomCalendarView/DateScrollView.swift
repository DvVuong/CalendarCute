//
//  DateScrollView.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct DateScrollView: View {
    @EnvironmentObject var dateHolper: DateHolder
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                previousMonth()
            }, label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.green.opacity(0.75))
            })
            
            Text(CalendarHelper().monthYearString(dateHolper.date))
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity)
            
            Button(action: {
                nextMonth()
            }, label: {
                Image(systemName: "arrow.right")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.green.opacity(0.75))
            })
            Spacer()
        }
    }
    
    func previousMonth() {
        dateHolper.date = CalendarHelper().perviousMonth(dateHolper.date)
    }
    
    func nextMonth() {
        dateHolper.date = CalendarHelper().plusMonth(dateHolper.date)
    }
}

struct DateScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollView()
    }
}
