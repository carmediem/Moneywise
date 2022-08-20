//
//  ImagePickerViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/21/22.
//

import UIKit
import SwiftUI

//need to pass a transaction into the imagepicker
//need to link the image and the transaction together.

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    
    @Environment(\.presentationMode) private var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var transactionNameText: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        var transactionNameText: String
        init(_ parent: ImagePicker, transactionNameText: String) {
            self.parent = parent
            self.transactionNameText = transactionNameText
        }
        
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                print("Saving")
                print(transactionNameText)
                
                ImageStorage.shared.saveImageToDocumentDirectory(image: image, name: transactionNameText)
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, transactionNameText: transactionNameText)
    }
}
