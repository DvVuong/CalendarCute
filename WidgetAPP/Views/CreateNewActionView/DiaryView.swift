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
enum ImagePickerSourceType: Identifiable {
    case camera, photolibrabri
    var id: Int {
        hashValue
    }
}

struct DiaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dateHodler: DateHolder
    @EnvironmentObject var coreData: CoreDataManager
    @State private var textContent: String = ""
    @State private var selectedIndex: Int = 0
    @State private var imagePicker: UIImage = UIImage(systemName: "photo")!
    @State private var isShowImagePicker: Bool = false
    @State private var imageSourceType: ImagePickerSourceType?
    @State private var emoji: UIImage = UIImage(named: "a")!
    
    @Binding var componenstType: ComponenstType
    let arrayImage: [ImageStruct] = [
        ImageStruct(id: 0, name: "a"),
        ImageStruct(id: 1, name: "b"),
        ImageStruct(id: 2, name: "e"),
        ImageStruct(id: 3, name: "d"),
        ImageStruct(id: 4, name: "f")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView()
                ContenView()
                Spacer()
            }
        }
        .onDisappear(perform: {
            coreData.fetchDataFromDiaryEntity()
        })
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading) {
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
            Text(dateHodler.date.formatter())
                .font(.system(size: 15))
            
        }
        .padding()
    }
    
    @ViewBuilder
    func ContenView() -> some View {
        VStack {
            VStack {
                ZStack {
                    MutilineTextFieldView(hint: "Hôm nay bạn có khỏe không?", text: $textContent, onEnd: {
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    })
                    .frame(width: 350, height: 250)
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
                        EmojiView(selectedImage: $selectedIndex, emoji: $emoji, image: image.name, imageTag: image)
                    }
                }
            }
            HStack {
                Button(action: {
                    isShowImagePicker.toggle()
                }, label: {
                    Image(uiImage: imagePicker)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                })
                
                Text("Chọn hình ảnh")
                    .font(.system(size: 20))
                Spacer()
            }
            .padding()
            .actionSheet(isPresented: $isShowImagePicker, content: {
                ActionSheet(title: Text("Chọn hình ảnh"), message: nil, buttons: [.cancel(), .default(Text("Thư viện ảnh"), action: {
                    imageSourceType = .photolibrabri
                }),.default(Text("chụp ảnh"), action: {
                    imageSourceType = .camera
                })])
            })
        }
        .fullScreenCover(item: $imageSourceType) { item in
            switch item {
            case .camera:
                ImagePickerView(image: $imagePicker, imagePickerSource: .camera)
            case .photolibrabri:
                ImagePickerView(image: $imagePicker, imagePickerSource: .photolibrabri)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 10, x: 2, y: 2)
        .padding()
    }
    
    private func saveDiary() {
        let diaryItem = DiaryItem(title: textContent,
                                  emoji: emoji.converImageToBase64String(),
                                  image: imagePicker.converImageToBase64String(),
                                  dateCreate: dateHodler.date)
        coreData.addDiaryItem(with: diaryItem)
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(componenstType: .constant(.Diary))
    }
}

struct EmojiView: View {
    @Binding var selectedImage: Int
    @Binding var emoji: UIImage
    var image: String
    var imageTag: ImageStruct
    var body: some View {
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
                    emoji = UIImage(named: image) ?? UIImage()
                }
        }
    }
}

struct MutilineTextFieldView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return MutilineTextFieldView.Coordinator(parent: self)
    }
    
    var hint: String
    @Binding var text: String
    
    var onEnd: () -> ()
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = hint
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 20)
        textView.delegate = context.coordinator
        
        let toobar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toobar.barStyle = .default
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.keyboardWillClose))
        
        toobar.items = [spacer,doneButton]
        toobar.sizeToFit()
        textView.inputAccessoryView = toobar
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    typealias UIViewType = UITextView
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MutilineTextFieldView
        
        init(parent: MutilineTextFieldView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.hint {
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
        
        @objc func keyboardWillClose() {
            parent.onEnd()
        }
    }
    
}
