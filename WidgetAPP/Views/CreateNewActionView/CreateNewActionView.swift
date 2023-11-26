//
//  CreateNewActionView.swift
//  WidgetAPP
//
//  Created by MRX on 10/21/23.
//

import SwiftUI
import UIKit

struct ColorStruct {
    var color: Color
}

struct CreateNewActionView: View {
    //Mark: - Environment
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreData: CoreDataManager
    //Mark: - @State
    @State private var headerTitle: String = ""
    @State private var title: String = "Tiêu đề"
    @State private var description: String = "Thêm chi tiết"
    @State private var isChooseAllDay: Bool = false
    @State private var isReminder: Bool = false
    @State private var isChooseTimeStart: Bool = false
    @State private var isChooseTimeEnd: Bool = false
    @State var selected = 0
    @State var customColor: ColorStruct = ColorStruct(color: .green)
    @State var keyboardIsPresented: Bool = false
    //Mark: -Binding
    @Binding var startDateChooseted: Date
    @Binding var endDateChooseted: Date
    
    let arrayButtom: [ButtomStruct] = [
        ButtomStruct(id: 0, color: Color.green),
        ButtomStruct(id: 1, color: Color.red),
        ButtomStruct(id: 2, color: Color.yellow),
        ButtomStruct(id: 3, color: Color.orange),
        ButtomStruct(id: 4, color: Color.pink),
        ButtomStruct(id: 5, color: Color.purple)
    ]
    var componenst: ComponenstType
    
    var body: some View {
        VStack(spacing: 1) {
            ScrollView {
                ZStack {
                    VStack {
                        headerView()
                            .frame(width: 350, height: 30)
                        ScrollView(showsIndicators: false) {
                            titleView()
                                .padding()
                            selecDate()
                                .padding()
                        }
                    }
                    
                    if isChooseTimeStart {
                        Color.black.opacity(0.25)
                        ChooseTimeDatePickerView(date: $startDateChooseted, cancel: $isChooseTimeStart, titleHeader: "Chọn thời gian bắt đầu")
                            .padding(.top, 380)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                            .onDisappear(perform: {
                                endDateChooseted = startDateChooseted
                            })
                    }else if isChooseTimeEnd {
                        Color.black.opacity(0.25)
                        ChooseTimeDatePickerView(date: $endDateChooseted, cancel: $isChooseTimeEnd, titleHeader: "Chọn thời gian kết thúc")
                            .padding(.top, 380)
                            .transition(.move(edge: .bottom))
                            .animation(.spring())
                    }
                }
            }
        }
        .onAppear(perform: {
            componenstType()
            let color = UserDefaultManager.shared.loadColor()
            let index = UserDefaultManager.shared.loadIndexColor()
            customColor.color = color
            selected = index
        })
        .onDisappear {
            coreData.fetchDataFromToDoEntities()
        }
    }
    
    @ViewBuilder
    func selecDate() -> some View {
        VStack(spacing: 1) {
            ZStack {
                Rectangle()
                    .frame(minWidth: 350, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                    .cornerRadius(20)
                    .shadow(color: Color.orange.opacity(0.5), radius: 10, x: 5, y: 5)
                    .foregroundColor(.white)
                
                VStack {
                    selecDateBody()
                }
            }
        }
    }
    
    @ViewBuilder
    func selecDateBody() -> some View {
        Section {
            VStack {
                HStack {
                    Toggle(isOn: $isChooseAllDay, label: {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(customColor.color)
                        Text("Cả ngày")
                    })
                    .toggleStyle(SwitchToggleStyle(tint: customColor.color))
                }
                .padding()
            }
            HStack{
                Button(action: {
                    /// To do action Choose Start time
                    isChooseTimeStart.toggle()
                }, label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(customColor.color)
                })
                Text(startDateChooseted.formatterDateStyle(with: "EEEE, MMM d, yyyy"))
                Spacer()
                Text(startDateChooseted.formatterDateStyle(with: "h:mm a"))
            }
            .padding()
            
            HStack{
                Button(action: {
                    /// Action choose time end
                    isChooseTimeEnd.toggle()
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(customColor.color)
                })
                
                Text(endDateChooseted.formatterDateStyle(with: "EEEE, MMM d, yyyy"))
                Spacer()
                Text(endDateChooseted.formatterDateStyle(with: "h:mm a"))
            }
            .padding()
        }
        Rectangle()
            .frame(width: 250, height: 1)
            .foregroundColor(.gray)
        HStack {
            Toggle(isOn: $isReminder, label: {
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(customColor.color)
                Text("Set reminder")
            })
            .toggleStyle(SwitchToggleStyle(tint: customColor.color))
        }
        .padding()
        
        HStack {
            Image(systemName: "clock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .foregroundColor(customColor.color)
            Text("15 minutes before")
            Spacer()
            Button(action: {
                /// To do action here
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(customColor.color)
            })
        }
        .padding()
        
        HStack {
            Button(action: {
                /// To do someThing here
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(customColor.color)
            })
            
            Text("Add reminder")
            Spacer()
        }
        .padding()
        
        HStack {
            Button(action: {
                /// To do someThing here
            }, label: {
                Image(systemName: "repeat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(customColor.color)
            })
            Text("Không bao giờ")
            Spacer()
        }
        .padding()
        
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "eyedropper")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(customColor.color)
                })
                Text("Custom")
                    .font(.title)
                    .bold()
                Spacer()
                
                Button(action: {
                    /// Action here
                }, label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(customColor.color)
                })
            }
            .padding()
            /// Mark: - Custom Color
            HStack(spacing: 10) {
                ForEach(arrayButtom, id: \.id) { button in
                    BoxView(selectedButton: $selected, buttonTag: button, color: $customColor)
                }
            }
            .padding()
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func titleView() -> some View {
        TitleComponenstView()
    }
    
    @ViewBuilder
    func TitleComponenstView() -> some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(minWidth: 350, maxWidth: .infinity, minHeight: 120, maxHeight: .infinity)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .shadow(color: Color.orange.opacity(0.5), radius: 7, x: 5, y: 5)
                HStack {
                    VStack(spacing: 0) {
                        MutilineTextFieldView(hint: "Tiêu đề", text: $title, onEnd: {
                            UIApplication.shared.sendAction(#selector(UITextView.resignFirstResponder), to: nil, from: nil, for: nil)
                        })
                        .frame(maxHeight: 35)
                        
                        MutilineTextFieldView(hint: "Thêm chi tiết", text: $description, onEnd: {
                            UIApplication.shared.sendAction(#selector(UITextView.resignFirstResponder), to: nil, from: nil, for: nil)
                        })
                        .frame(maxHeight: 80)
                        
                    }
                    .padding(.leading, 25)
                    Spacer()
                    Button(action: {
                        /// To do some thing here
                    }, label: {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(customColor.color)
                            Text("Sticker")
                                .foregroundColor(Color.black)
                        }
                    })
                    .padding(.trailing, 15)
                    .padding(.top, -40)
                    Spacer()
                }
                .padding(.top, -1)
            }
            Spacer()
        }
    }
    
    /// Mark: - Header View
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            Button(action: {
                /// To do some thing here
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(customColor.color)
            })
            Spacer()
            
            Text(headerTitle)
                .font(.system(size: 25, weight: .regular))
            Spacer()
            Button(action: {
                saveTask()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName:"checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(customColor.color)
            })
        }
        .padding(.top, 10)
    }
    
    func saveTask() {
     let color = TintColor.shared.setUpColor(with: customColor.color)
        let task = TaskItem(id: UUID(),
                            taskType: componenst.self,
                            taskTitle: title,
                            taskDescription: description,
                            creationDate: startDateChooseted,
                            endDate: endDateChooseted,
                            tint: color.self,
                            isAllDay: true,
                            isSetReminder: true,
                            alertBefore: Date(),
                            isCompelete: true)
        coreData.addDataToTodoEntities(with: task)
    }
    
    func componenstType() {
        let type = componenst.self
        switch type {
        case .Event:
            headerTitle = "Event"
        case .Todo:
            headerTitle = "Todo"
        case .Memo:
            headerTitle = "Memo"
        case .Diary:
            headerTitle = "Diary"
        }
    }
}

struct CreateNewActionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewActionView(startDateChooseted: .constant(Date()), endDateChooseted: .constant(Date()), componenst: .Event)
    }
}

struct BoxView: View {
    @EnvironmentObject var coreData: CoreDataManager
    @Binding var selectedButton: Int
    var buttonTag: ButtomStruct
    @Binding var color: ColorStruct
    var body: some View {
        Button(action: {
            self.selectedButton = self.buttonTag.id
            self.color.color = buttonTag.color
            UserDefaultManager.shared.saveColor(with: color.color)
            UserDefaultManager.shared.saveIndexColor(with: self.selectedButton)
        }, label: {
            Image(systemName: (selectedButton == self.buttonTag.id) ? "largecircle.fill.circle" : "circle.fill" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(buttonTag.color)
        })
    }
}
