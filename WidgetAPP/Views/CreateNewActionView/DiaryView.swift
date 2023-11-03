//
//  DiaryView.swift
//  WidgetAPP
//
//  Created by MRX on 10/30/23.
//

import SwiftUI

struct ImageStruct: Identifiable {
    var id: Int
    var name: String
}

struct DiaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var textContent: String = ""
    @State private var selectedIndex: Int = 0
    @State private var hello: String = "Hôm nay bạn có khỏe không?"
    @Binding var componenstType: ComponenstType
    let arrayImage: [ImageStruct] = [
        ImageStruct(id: 0, name: "a"),
        ImageStruct(id: 1, name: "b"),
        ImageStruct(id: 2, name: "e"),
        ImageStruct(id: 3, name: "d"),
        ImageStruct(id: 4, name: "f")
    ]
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 30, maximum: 30))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView()
                ContenView()
                Spacer()
            }
        }
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(.green)
            })
            Spacer()
            Text(componenstType.rawValue)
            Spacer()
            Button(action: {
                saveDiary()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.green)
                
            })
        }
        .padding()
    }
    @ViewBuilder
    func ContenView() -> some View {
        VStack {
            VStack {
                ZStack {
                    TextEditor(text: $textContent)
                        .frame(width: 350, height: 250)
                        .cornerRadius(25)
                        .onTapGesture {
                            hello = ""
                        }
                        .onChange(of: "", perform: { value in
                            print("vuongdv value! \(value)")
                        })
                        
                        
                    Text(hello)
                        .padding(.top, -110)
                        .padding(.leading, -90)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 10, x: 5, y: 5)
        .padding()
        
        VStack {
            Text("Selected Emoji")
                .font(.title)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(arrayImage, id: \.id) { image in
                        ImageView(selectedImage: $selectedIndex, image: image.name, imageTag: image)
                    }
                }
            }
        }
        
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 10, x: 2, y: 2)
        .padding()
    }
    
    private func saveDiary() {
        presentationMode.wrappedValue.dismiss()
    }
}

@ViewBuilder
func SelecEmoji(_ stringImage: String) -> some View {
    Button(action: {
        
    }, label: {
        Image(stringImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .padding()
    })
}


struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(componenstType: .constant(.Diary))
    }
}

struct ImageView: View {
    @Binding var selectedImage: Int
    var image: String
    var imageTag: ImageStruct
    var body: some View {
        //HStack {
        VStack {
            if selectedImage == imageTag.id {
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.blue)
            }
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(75)
                .onTapGesture {
                    selectedImage = imageTag.id
                }
        }
    }
}
