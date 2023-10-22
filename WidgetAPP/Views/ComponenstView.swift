//
//  ComponenstView.swift
//  WidgetAPP
//
//  Created by MRX on 10/21/23.
//

import SwiftUI
enum ComponenstType {
    case Event, Todo, Memo, Diary
}

struct ComponenstView: View {
    @Binding var isShowCreateView: Bool
    @Binding var componenstType: ComponenstType
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
                        ItemsView("calendar.circle.fill", title: "Event", color: .green, componenstType: .Event)
                        ItemsView("chevron.down.circle.fill", title: "To do", color: .orange, componenstType: .Todo)
                        ItemsView("doc.text", title: "Memo", color: .yellow, componenstType: .Memo)
                        ItemsView("pencil.circle.fill", title: "Diary", color: .gray, componenstType: .Diary)
                }
            }
        }
    }
    
    @ViewBuilder
    func ItemsView(_ icon: String, title: String, color: Color, componenstType: ComponenstType) -> some View {
        VStack {
            Button(action: {
                isShowCreateView.toggle()
                switch componenstType {
                case .Event:
                    self.componenstType = .Event
                case .Todo:
                    self.componenstType = .Todo
                case .Memo:
                    self.componenstType = .Memo
                case .Diary:
                    self.componenstType = .Diary
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

struct ComponenstView_Previews: PreviewProvider {
    static var previews: some View {
        ComponenstView(isShowCreateView: .constant(false), componenstType: .constant(.Todo))
    }
}
