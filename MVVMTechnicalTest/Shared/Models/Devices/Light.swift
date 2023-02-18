//
//  Light.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

struct Light: Device, Configurable {
    let id: UInt
    let deviceName: String
    let productType: String
    let mode: Bool

    let intensity: UInt

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

    private func getMode() -> String {
        return mode ? "On" : "Off"
    }
}
