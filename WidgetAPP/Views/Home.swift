//
//  Home.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct Home: View {
    /// Task Manager Properties
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.Weekdays]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    /// Animation NameSpace
    
    @Namespace private var animation
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView()
        }
        .wSpacing(.top)
        .overlay(buttonCreatetask(), alignment: .bottomTrailing)
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first  {
                    weekSlider.append(firstDate.date.creatpreviousWeekNext())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last {
                    weekSlider.append(lastDate.date.creatWeekNext())
                }
            }
        })
    }
    
    @ViewBuilder
     func headerView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMM"))
                    .foregroundColor(Color.blue)
                Text(currentDate.format("YYY"))
                    .foregroundColor(Color.secondary)
                
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image("a")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                })
            }
            .font(.title)
            
            Text(currentDate.formatter())
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            // Week slider
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 10)
                        .tag(index)
                }
            }
            .padding(.horizontal, -10)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 90)
            
        }
        .hSpacing(.leading)
        .padding(10)
        .background(Color.white)
        .onChange(of: currentWeekIndex, perform: { value in
            if value == 0 || value == (weekSlider.count - 1) {
                createWeek = true
            }
        })
     }
    
    /// Week View
    
    @ViewBuilder
    func WeekView(_ week: [Date.Weekdays]) -> some View {
        HStack(spacing:0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    VStack(spacing: 5) {
                        Text(day.date.format("E"))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text(day.date.format("dd"))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(isSameDate(day.date, date2: currentDate) ? Color.white : Color.gray)
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                            .background(setBackgroundColor(day), alignment: .bottom)
                    }
                    
                    if day.date.isToday {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 5, height: 5)
                            .background(Color.clear)
                    }
                }
                .hSpacing(.center)
                .contentShape(Circle())
                .onTapGesture {
                    /// Updating Current Day
                    withAnimation(.default) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background(GeometryReader(content: { geometry in
            let minX = geometry.frame(in: .global).minX
            Color.clear
                .preference(key: OffsetKey.self, value: minX)
                .onPreferenceChange(OffsetKey.self, perform: { value in
                    /// When the Offset reaches 15 and if the create Week is toggle
                    if value.rounded() == 10 && createWeek {
                        paginateWeek()
                        createWeek = false
                    }
                })
        }))
    }
    
    @ViewBuilder
    func setBackgroundColor(_ day: Date.Weekdays) -> some View {
        if isSameDate(day.date, date2: currentDate) {
            Color.blue.shadow(color: .gray, radius: 2, x: 1, y: 1)
        }else {
            Color.white.shadow(color: .gray, radius: 2, x: 1, y: 1)
        }
    }
    func paginateWeek() {
        /// Safe Check
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate =  weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                /// inserting New Week at 0th Index and Removing last Array item
                weekSlider.insert(firstDate.creatpreviousWeekNext(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.creatWeekNext())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
    
    @ViewBuilder
    func buttonCreatetask() -> some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.blue.shadow(color: Color.black.opacity(0.25), radius: 5, x: 10, y: 10))
        })
        .clipShape(Circle())
        .padding(15)
        .shadow(color: Color.black.opacity(0.25), radius: 5, x: 5, y: 5)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
