//
//  TaskView.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreData: CoreDataManager
    @EnvironmentObject var dateHolder: DateHolder
    @State var itemsTodo: ToDoEntity = .init()

    @State var isShow: Bool = false
    var dayOfMonth: String
    var checkEmtyItem: Bool = false
    @State private var starDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var indexOfItem: Int = 0
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView()
                .padding()
            Text(starDate.formatter())
                .font(.title)
                .foregroundColor(.orange)
                .padding()
            ScrollView(showsIndicators: false) {
                ForEach(coreData.todoArrays.indices, id: \.self) { index in
                    let item = coreData.todoArrays[index]
                    if checkCreateDay(with: item.creationDate ?? Date()) {
                        ItemsView(with: item)
                            .onTapGesture(perform: {
                                self.itemsTodo = item
                                self.isShow.toggle()
                                self.indexOfItem = index
                            })
                            .fullScreenCover(isPresented: $isShow, content: {
                                DetailTaskView(task: $itemsTodo, indexOfItem: $indexOfItem)
                            })
                    }
                }
            }
        }
        .wSpacing(.top)
        .hSpacing(.leading)
        .overlay(createButtonTask(), alignment: .bottomTrailing)
        .onAppear {
            let nameMonth = dateHolder.date.formatterDateStyle(with: "LLL")
            let dayOfMont = CalendarHelper().convertNameMonthToInt(with: nameMonth)
            let yearInt = dateHolder.date.formatterDateStyle(with: "yyyy")
            let dayIntMonth = CalendarHelper().getDayOfMonthForInt(with: Int(dayOfMonth) ?? 0, month: dayOfMont ?? 0, year: Int(yearInt) ?? 0)
            starDate = dayIntMonth
            endDate = dayIntMonth

        }
    }
    
    @ViewBuilder
    func ItemsView(with item: ToDoEntity) -> some View {
        HStack {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.yellow)
                
                Rectangle()
                    .frame(maxWidth: 1, maxHeight: 35)
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .frame(maxWidth: 4, maxHeight: 40)
                            .foregroundColor(.green)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                        VStack(alignment: .leading) {
                            Text(item.taskTitle ?? "")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(Color.green)
                            Text(item.taskDescription ?? "")
                        }
                        Spacer()
                        VStack {
                            Text("Ngay ket thuc")
                            Text(item.endDate?.format("EEE, MMM d") ?? "")
                                .font(.system(size: 15))
                        }
                    }
                    .padding()
                }
            }
            .background(
                Color.white
            )
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 1, y: 1)
        }
        .hSpacing(.leading)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 150)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        })
    }
    
    @ViewBuilder
    func createButtonTask() -> some View {
        Button(action: {
            
        }, label: {
            NavigationLink(
                destination: CreateNewActionView(startDateChooseted: $starDate, endDateChooseted: $endDate, componenst: .Event)
                    .navigationBarHidden(true),
                label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                })
        })
        .clipShape(Circle())
        .padding(15)
        .shadow(color: Color.black.opacity(0.25), radius: 5, x: 5, y: 5)
    }
    
    private func checkCreateDay(with dateCreate: Date) -> Bool {
        let createDayInt = CalendarHelper().dayOfMonth(dateCreate)
        let createMonth = CalendarHelper().monthYearString(dateCreate)
        
        if String(createDayInt) == dayOfMonth && createMonth == CalendarHelper().monthYearString(dateHolder.date) {
            return true
        }else {
            return false
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(dayOfMonth: "")
    }
}
