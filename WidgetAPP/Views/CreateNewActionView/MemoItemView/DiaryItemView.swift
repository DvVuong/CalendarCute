//
//  DiaryItemView.swift
//  WidgetAPP
//
//  Created by MRX on 11/24/23.
//

import SwiftUI

struct DiaryItemView: View {
    var diary: DiaryEntity
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                    HStack {
                        Text(diary.title ?? "")
                            .font(.title)
                            .bold()
        
                        Image(uiImage: diary.emoji?.converBase64ToImage() ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80, maxHeight: 150)
                            
                    }
                    
                Text("diary.")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                Spacer()
                
                Text(diary.dateCreate?.format("MM/dd/yyyy") ?? "")
                        .padding()
                        .frame(maxWidth: 125, maxHeight: 25)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(5)
                    
                
                }
            Spacer()
        }
        .padding()
        .frame(maxWidth: 300, maxHeight: 350)
        .background(Color.white)
        .padding()
        .cornerRadius(65)
        .shadow(color: .gray, radius: 5, x: 1, y: 1)
    }
    
}

struct DiaryItemView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryItemView(diary: .init())
    }
}
