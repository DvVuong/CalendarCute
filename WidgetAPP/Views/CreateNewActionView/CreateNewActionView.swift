//
//  CreateNewActionView.swift
//  WidgetAPP
//
//  Created by MRX on 10/21/23.
//

import SwiftUI

enum ColorType: String {
    case green = "green"
    case red = "red"
    case blue = "blue"
    case yellow = "yellow"
    case orange = "orange"
    case pink  = "pink"
    case purple = "purple"
}
struct CreateNewActionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var headerTitle: String = ""
    @State private var title: String = "Tiêu đề"
    @State private var description: String = "Thêm chi tiết"
    @State private var isChooseAllDay: Bool = false
    @State private var isReminder: Bool = false
    
    var componenst: ComponenstType
    
    var body: some View {
        VStack(spacing: 1) {
            headerView()
                .frame(width: 350, height: 30)
                
            ScrollView(showsIndicators: false) {
                titleView()
                    .padding()
                selecDate()
                    .padding()
            }
        }
        .onAppear(perform: {
            componenstType()
        })
    }
    
    @ViewBuilder
    func selecDate() -> some View {
        VStack(spacing: 1) {
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 535)
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
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.green.opacity(0.75))
                        Text("Cả ngày")
                    })
                }
                .padding()
            }
            HStack{
                Button(action: {
                    /// To do some thing here
                    print("vuongdv right")
                }, label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.green.opacity(0.75))
                })
                Text(CalendarHelper().convertCurrentDayString(with: .full))
                Spacer()
                Text(CalendarHelper().currentTimeString(with: "h:mm a"))
            }
            .padding()
            
            HStack{
                Button(action: {
                    print("vuongdv left")
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.green.opacity(0.75))
                })
                
                Text(CalendarHelper().convertCurrentDayString(with: .full))
                Spacer()
                Text(CalendarHelper().currentTimeString(with: "h:mm a"))
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.green.opacity(0.75))
                Text("Set reminder")
            })
        }
        .padding()
        
        HStack {
            Image(systemName: "clock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color.green.opacity(0.75))
            Text("15 minutes before")
            Spacer()
            Button(action: {
                /// To do action here
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.green.opacity(0.75))
                
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.green.opacity(0.75))
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.green.opacity(0.75))
            })
            Text("Không bao giờ")
            Spacer()
        }
        .padding()
        HStack {
            Button(action: {
                
            }, label: {
                Image(systemName: "eyedropper")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.green.opacity(0.75))
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.green.opacity(0.75))
            })
        
        }
        .padding()
    }
    
    @ViewBuilder
    func changeColorButtoms(with color: ColorType) -> some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
        })
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
                    .frame(width: 350, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .shadow(color: Color.orange.opacity(0.5), radius: 7, x: 5, y: 5)
                HStack {
                    VStack(spacing: 0) {
                        TextEditor(text: $title)
                            .font(.system(size: 25, weight: .semibold))
                            .frame(maxHeight: 35)
                            .onTapGesture {
                                title = ""
                            }
                            .onChange(of: title, perform: { value in
                                title = value
                            })
                        
                        TextEditor(text: $description)
                            .frame(height: 80)
                            .onTapGesture {
                                description = ""
                            }
                            .onChange(of: description, perform: { value in
                                description = value
                            })
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
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color.green.opacity(0.5))
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
                    .foregroundColor(Color.green.opacity(0.75))
            })
            Spacer()
            
            Text(headerTitle)
                .font(.system(size: 25, weight: .regular))
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName:"checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.green.opacity(0.75))
            })
        }
        .padding()
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
        CreateNewActionView(componenst: .Event)
    }
}
