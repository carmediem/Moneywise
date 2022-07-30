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
    var transaction: Transaction
    
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
        var transaction: Transaction
        init(_ parent: ImagePicker, transaction: Transaction) {
            self.parent = parent
            self.transaction = transaction
        }
        
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                print("Saving")
                
                ImageStorage.shared.saveImageToDocumentDirectory(image: image, name: transaction.name ?? "Transaction Photo")
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, transaction: transaction)
    }
}
