//
//  Device.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

protocol Device: Codable {
    var id: UInt { get }
    var deviceName: String { get }
    var productType: String { get }

    func getDisplayString() -> String
    func getImage() -> UIImage
}

protocol Configurable: Codable {
    var mode: Bool { get }
}
