//
//  Heater.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

private enum Constants {
    static let heaterMaxTemperature: UInt = 28
    static let heaterMinTemperature: UInt = 7
}

final class Heater: Device, Configurable, Activable {

    let id: UInt
    let deviceName: String
    let productType: String
    var mode: Bool

    var temperature: Float

    enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case productType
        case mode

        case temperature
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
        temperature = try values.decode(Float.self, forKey: .temperature)
    }

    func getStatus() -> String {
        if !self.mode {
            return "\(self.getMode())"
        }
        return Strings.Device.Heater.status(self.getMode(), self.getCurrentValue())
    }

    func getImage() -> UIImage {
        if mode {
            return getOnImage()
        }
        return getOffImage()
    }

}

// MARK: - Configurable

extension Heater {
    func setCurrentValue(newValue: Float) {
        self.temperature = newValue
    }

    func getCurrentValue() -> Float {
        self.temperature
    }

    func getMaxValue() -> UInt {
        Constants.heaterMaxTemperature
    }

    func getMinValue() -> UInt {
        Constants.heaterMinTemperature
    }
}

// MARK: - Activable

extension Heater {
    func getOnImage() -> UIImage {
        return Assets.Images.Device.deviceHeaterOnIcon.image
    }

    func getOffImage() -> UIImage {
        return Assets.Images.Device.deviceHeaterOffIcon.image
    }
}
