//
//  ColorExtension.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/11/22.
//

import SwiftUI
import Foundation

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}




//MARK: Extension for currency converter
//extension String {
//    static let numberFormatter = NumberFormatter()
//    var doubleValue: Double {
//        String.numberFormatter.decimalSeparator = "."
//        if let result = String.numberFormatter.number(from: self) {
//            return result.doubleValue
//        } else {
//            String.numberFormatter.decimalSeparator = ","
//            if let result = String.numberFormatter.number(from: self) {
//                return result.doubleValue
//            }
//        }
//        return 0
//    }
//}
