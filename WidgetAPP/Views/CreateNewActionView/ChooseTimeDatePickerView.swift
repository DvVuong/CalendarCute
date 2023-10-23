//
//  ChooseTimeDatePickerView.swift
//  WidgetAPP
//
//  Created by MRX on 10/22/23.
//

import SwiftUI

struct ChooseTimeDatePickerView: View {
    @Binding var date: Date
    @Binding var cancel: Bool
     var titleHeader: String
    
    var body: some View {
        VStack(spacing: 0) {
            headerView()
            DatePicker("", selection: $date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
                .background(Color.white)
            Spacer()
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            Button(action: {
                cancel.toggle()
                date = Date()
            }, label: {
                Text("Hủy")
            })
            Spacer()
            
            Text(titleHeader)
            
            Spacer()
            Button(action: {
                saveTimeChoose()
            }, label: {
                Text("Xong")
            })
        }
        .background(Color.white)
        .padding()
        .frame(height: 50)
    }
    
    func saveTimeChoose() {
        /// Todo something here
        cancel.toggle()
    }
}

struct ChooseTimeDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTimeDatePickerView(date: .constant(Date()), cancel: .constant(false), titleHeader: "")
    }
}
