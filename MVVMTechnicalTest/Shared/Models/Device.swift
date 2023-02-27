//
//  Device.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

protocol Device: Codable {
    var id: Int { get }
    var deviceName: String { get }
    var productType: String { get }

    func getStatus() -> String
    func getImage() -> UIImage
    func isConfigurable() -> Bool
    func isActivable() -> Bool
}

protocol Activable {
    var mode: Bool { get set }

    func getMode() -> String
    func getOffImage() -> UIImage
    func getOnImage() -> UIImage
}

protocol Configurable: Codable {
    func setCurrentValue(newValue: Float)
    func getCurrentValue() -> Float
    func getMaxValue() -> UInt
    func getMinValue() -> UInt
}

// MARK: - Default implementations

extension Activable {
    func getMode() -> String {
        return mode ? Strings.Device.on : Strings.Device.off
    }
}

extension Device {
    func isConfigurable() -> Bool {
        return self is Configurable
    }

    func isActivable() -> Bool {
        return self is Activable
    }
}
