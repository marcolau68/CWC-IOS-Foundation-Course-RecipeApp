//
//  ImagePicker.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment (\.presentationMode) var presentationMode
    
    @Binding var recipeImage: UIImage?
    
    var source: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = source
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // check if we can get the image
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.recipeImage = image
                
                // close ImagePicker after image is chosen
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}





