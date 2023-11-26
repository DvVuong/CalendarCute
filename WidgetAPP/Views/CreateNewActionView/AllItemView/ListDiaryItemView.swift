//
//  ListDiaryItemView.swift
//  WidgetAPP
//
//  Created by MRX on 11/26/23.
//

import SwiftUI

struct ListDiaryItemView: View {
    @EnvironmentObject var coreData: CoreDataManager
    var diaryItem: DiaryEntity = .init()
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                ItemsDiaryView()
                Spacer()
            }
            .padding(.leading, -25)
            
            HStack {
                DetailDiaryView()
                Spacer()
            }
            .padding(.leading, -25)
        }
    }
    
    @ViewBuilder
    func ItemsDiaryView() -> some View {
        VStack {
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(maxWidth: 10, maxHeight: 10)
                    .padding(.leading, 25)
                Spacer()
                Text(diaryItem.dateCreate?.format("MM/dd/yyyy") ?? "")
                    .font(.system(size: 25))
                    .bold()
            }
            .frame(maxWidth: 200, maxHeight: 50)
            .background(Color.pink.opacity(0.2))
            .padding(.leading, 25)
            .cornerRadius(10)
        }
    }
    @ViewBuilder
    func DetailDiaryView() -> some View {
        HStack {
            Text(diaryItem.dateCreate?.format("hh:mm a") ?? "")
                .bold()
                .padding(.leading, 45)
            
            HStack {
                Text(diaryItem.title ?? "")
                Spacer()
                Image(uiImage: diaryItem.emoji?.converBase64ToImage() ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 45, maxHeight: 50)
            }
            .frame(maxWidth: 350, maxHeight: 250)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 2, y: 2)
        }
    }
}

struct ListDiaryItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListDiaryItemView()
    }
}
