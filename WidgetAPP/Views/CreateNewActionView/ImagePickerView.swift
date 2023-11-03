//
//  ImagePickerView.swift
//  WidgetAPP
//
//  Created by MRX on 10/30/23.
//

import SwiftUI
import UIKit
import Photos

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        ///
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
}

extension ImagePickerView {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerView
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = pickerImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
