//
//  TransactionDetailViewModel.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/23/22.
//

import SwiftUI


func compressImage(image: UIImage) -> UIImage {
        let resizedImage = image.aspectFittedToHeight(200)
    resizedImage.jpegData(compressionQuality: 1.0) 

        return resizedImage
}
