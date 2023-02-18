//
//  RollerShutter.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

private enum Constants {
    static let rollerShutterMaxPosition: UInt = 100
    static let rollerShutterMinPosition: UInt = 0
}

final class RollerShutter: Device, Configurable {
    let id: UInt
    let deviceName: String
    let productType: String

    var position: Float

    enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case productType
        case position
    }

    init(
        from decoder: Decoder
    ) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(UInt.self, forKey: .id)
        deviceName = try values.decode(String.self, forKey: .deviceName)
        productType = try values.decode(String.self, forKey: .productType)
        position = try values.decode(Float.self, forKey: .position)
    }

    func getStatus() -> String {
        if position >= 100 {
            return "Opened"
        } else if position <= 0 {
            return "Closed"
        }
        return "Opened at \(Int(position))%"
    }

    func getImage() -> UIImage {
        return Assets.Images.Device.deviceRollerShutterIcon.image
    }
}

// MARK: - Configurable

extension RollerShutter {
    func setCurrentValue(newValue: Float) {
        self.position = newValue
    }

    func getCurrentValue() -> Float {
        self.position
    }

    func getMaxValue() -> UInt {
        Constants.rollerShutterMaxPosition
    }

    func getMinValue() -> UInt {
        Constants.rollerShutterMinPosition
    }
}
