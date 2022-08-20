//
//  ImageStorage.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/29/22.
//

import SwiftUI
import UIKit

class ImageStorage {
    static let shared = ImageStorage()
    private init() {}
    
    func saveImageToDocumentDirectory(image: UIImage, name: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 0.2), !FileManager.default.fileExists(atPath: fileURL.path)
        {
            do {
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    func loadImageFromDocumentDirectory(nameOfImage: String) -> UIImage? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image = UIImage(contentsOfFile: imageURL.path)
            return image
        }
        return UIImage.init(named: "default.png")!
    }
}

extension UIImage {
    func aspectFittedToHeight(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
