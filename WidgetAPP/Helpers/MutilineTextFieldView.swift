//
//  MutilineTextFieldView.swift
//  WidgetAPP
//
//  Created by MRX on 11/24/23.
//

import Foundation
import SwiftUI
import UIKit

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
