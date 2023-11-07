//
//  DetailDiaryView.swift
//  WidgetAPP
//
//  Created by MRX on 11/7/23.
//

import SwiftUI

struct DetailDiaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var diaryItem: DiaryEntity
    @State var emoji: UIImage = UIImage(named: "c")!
    var body: some View {
        VStack {
            HeaderView()
            contenView()
            Spacer()
        }
        .onAppear(perform: {
            let image = diaryItem.emoji?.converBase64ToImage() ?? UIImage()
            emoji = image
        })
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
            })
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    func contenView() -> some View {
        
        VStack {
            VStack {
                HStack {
                    Text(diaryItem.title ?? "")
                        .padding()
                        .padding(.top, -30)
                    Spacer()
                    Image(uiImage: emoji)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 100)
                        .padding(.trailing, 10)
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 3, y: 3)
            .padding()
            
        }
    }
}

struct DetailDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailDiaryView(diaryItem: .constant(.init()))
    }
}
