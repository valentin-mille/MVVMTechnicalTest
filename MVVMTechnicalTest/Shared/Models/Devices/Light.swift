//
//  Light.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

private enum Constants {
    static let lightMaxIntensity: UInt = 100
    static let lightMinIntensity: UInt = 0
}

final class Light: Device, Configurable, Activable {

    let id: UInt
    let deviceName: String
    let productType: String
    var mode: Bool

    var intensity: UInt

    enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case mode
        case productType
        case intensity
    }

    init(
        from decoder: Decoder
    ) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(UInt.self, forKey: .id)
        deviceName = try values.decode(String.self, forKey: .deviceName)
        productType = try values.decode(String.self, forKey: .productType)
        let tmpMode = try values.decode(String.self, forKey: .mode)
        mode = tmpMode == "ON" ? true : false
        intensity = try values.decode(UInt.self, forKey: .intensity)
    }

    func getDisplayString() -> String {
        return "\(getMode()) at \(intensity)%"
    }

    func getImage() -> UIImage {
        if mode {
            return Assets.Images.Device.deviceLightOnIcon.image
        }
        return Assets.Images.Device.deviceLightOffIcon.image
    }

}

// MARK: - Configurable

extension Light {
    func setCurrentValue(newValue: UInt) {
        self.intensity = newValue
    }

    func getCurrentValue() -> UInt {
        self.intensity
    }

    func getMaxValue() -> UInt {
        Constants.lightMaxIntensity
    }

    func getMinValue() -> UInt {
        Constants.lightMinIntensity
    }
}

// MARK: - Activable

extension Light {
    func getOnImage() -> UIImage {
        return Assets.Images.Device.deviceLightOnIcon.image
    }

    func getOffImage() -> UIImage {
        return Assets.Images.Device.deviceLightOffIcon.image
    }
}
