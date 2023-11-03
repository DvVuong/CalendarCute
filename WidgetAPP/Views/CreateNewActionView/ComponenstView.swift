//
//  ComponenstView.swift
//  WidgetAPP
//
//  Created by MRX on 10/21/23.
//

import SwiftUI
enum ComponenstType: String {
    case Event = "Event"
    case Todo = "Todo"
    case Memo = "Memo"
    case Diary = "Diary"
}
struct ButtonItems: Identifiable {
    var id: Int
    var icon: String
    var title: String
    var color: Color
    //var componenstType: ComponenstType
}

struct ComponenstView: View {
    @Binding var acctionSheet: AcctionSheet?
    @Binding var componenstType: ComponenstType
    
    @State private var selectedIndex: Int = 0
    
     var arraysButton: [ButtonItems] = [
        ButtonItems(id: 0 , icon: "calendar.circle.fill", title: "Event", color: .green),
        ButtonItems(id: 1 ,icon: "chevron.down.circle.fill", title: "To do", color: .orange),
        ButtonItems(id: 2 , icon:"doc.text", title: "Memo", color: .yellow),
        ButtonItems(id: 3, icon: "pencil.circle.fill", title: "Diary", color: .gray)
    ]
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(color: Color.orange.opacity(0.25), radius: 10, x: 5, y: 5)
            
            VStack(alignment: .center,spacing: 20) {
                Text("Bạn có kế hoạch gì không?")
                    .font(.title2)
                    .bold()
                    .padding()
                
                HStack(spacing: 25) {
                    ForEach(arraysButton, id: \.id) { button in
                        ButtonView(acctionSheet: $acctionSheet, selectedButton: $selectedIndex,
                                   componenstType: $componenstType, icon: button.icon,
                                   title: button.title,
                                   color: button.color,
                                   buttonTag: button)
                    }
                }
            }
        }
    }
}

struct ComponenstView_Previews: PreviewProvider {
    static var previews: some View {
        ComponenstView(acctionSheet: .constant(.first), componenstType: .constant(.Event))
    }
}

struct ButtonView: View {
    @Binding var acctionSheet: AcctionSheet?
    @Binding var selectedButton: Int
    @Binding var componenstType: ComponenstType
    var icon: String
    var title: String
    var color: Color
    var buttonTag: ButtonItems
  
    var body: some View {
        VStack {
            Button(action: {
                selectedButton = buttonTag.id
                switch buttonTag.id {
                case 0:
                    acctionSheet = .first
                    componenstType = .Event
                case 1:
                    acctionSheet = .first
                    componenstType = .Todo
                case 2:
                    acctionSheet = .second
                    componenstType = .Memo
                case 3:
                    acctionSheet = .second
                    componenstType = .Diary
                default:
                    break
                }
                
            }, label: {
                VStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(color).opacity(0.7)
                    Text(title)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                
            })
        }
        
    }
}
