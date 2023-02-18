//
//  UImage+Resize.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation
import UIKit

extension UIImage {
    func withSize(of newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
