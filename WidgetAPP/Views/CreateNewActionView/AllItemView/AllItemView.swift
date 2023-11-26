//
//  AllItemView.swift
//  WidgetAPP
//
//  Created by MRX on 11/24/23.
//

import SwiftUI

struct AllItemView: View {
    @EnvironmentObject var coreData: CoreDataManager
    @Environment(\.presentationMode) var presentationMode
    @State private var index: Int = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                })
                .padding()
                Spacer()
            }
            
            Picker("", selection: $index) {
                Text("Todo").bold().tag(0)
                Text("Memo").bold().tag(1)
                Text("Diary").bold().tag(2)
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            .foregroundColor(.blue)
            
            switch index {
            case 0:
                TodoView()
            case 1:
                MemoView()
            case 2:
                ScrollView(showsIndicators: false) {
                    ForEach(coreData.diaryArrays, id: \.self) { item in
                        ListDiaryItemView(diaryItem: item)
                    }
                }
                .frame(maxHeight: .infinity)
                
            default:
                TodoView()
            }
            Spacer()
        }
        .onAppear(perform: {
            let arr: [Int] = [1, 2, 2, 4, 5, 6, 7]
            var result: [Int] = []
            for i in 0..<arr.count {
                for j in (i+1)..<arr.count {
                    if arr[i] == arr[j] {
                        result.append(arr[i])
                    }
                }
            }
            print("vuongdv result", result)
        })
    }
}

struct AllItemView_Previews: PreviewProvider {
    static var previews: some View {
        AllItemView()
    }
}

struct TodoView: View {
    var body: some View {
        VStack {
            Text("Todo view")
        }
    }
}

struct MemoView: View {
    @EnvironmentObject var coreData: CoreDataManager
    
    private var colunms: [GridItem] = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: colunms, spacing:  5 ,content: {
                    ForEach(coreData.diaryArrays, id: \.self) { item in
                        DiaryItemView(diary: item)
                    }
                })
            }
        }
    }
}

