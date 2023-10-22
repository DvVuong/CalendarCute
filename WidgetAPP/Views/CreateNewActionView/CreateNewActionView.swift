//
//  CreateNewActionView.swift
//  WidgetAPP
//
//  Created by MRX on 10/21/23.
//

import SwiftUI

struct CreateNewActionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var headerTitle: String = ""
    @State private var title: String = "Tiêu đề"
    @State private var description: String = "Thêm chi tiết"
    @State private var isChooseAllDay: Bool = false
    
    var componenst: ComponenstType
    
    var body: some View {
        VStack(spacing: 1) {
            headerView()
            Spacer()
            titleView()
            Spacer()
            selecDate()
            Spacer()
        }
        
        .onAppear(perform: {
            componenstType()
        })
    }
    
    @ViewBuilder
    func selecDate() -> some View {
        VStack {
            ZStack {
                
            }
        }
        .background(Color.white)
        .shadow(color: Color.orange.opacity(0.5), radius: 10, x: 5, y: 5)
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
                    .shadow(color: Color.orange.opacity(0.5), radius: 10, x: 7, y: 7)
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
                    .padding(.trailing, 10)
                    .padding(.top, -40)
                    Spacer()
                }
                .padding(.top, -5)
            }
            Spacer()
        }
    }
    
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
