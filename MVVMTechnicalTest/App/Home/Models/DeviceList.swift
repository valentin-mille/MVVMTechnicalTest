//
//  DeviceList.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation

struct DeviceList: Decodable {
    let devices: [DeviceType]

    enum CodingKeys: String, CodingKey {
        case devices
    }
}

enum DeviceType: Decodable {
    case light(Light)
    case heater(Heater)
    case rollerShutter(RollerShutter)

    enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case intensity
        case mode
        case position
        case productType
        case temperature
    }

    enum DeviceTypeIdentifier: String, Codable {
        case light = "Light"
        case heater = "Heater"
        case rollerShutter = "RollerShutter"
    }

    init(
        from decoder: Decoder
    ) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let productType = try values.decode(DeviceTypeIdentifier.self, forKey: .productType)

        switch productType {
        case .light:
            if let light = try? Light(from: decoder) {
                self = .light(light)
                return
            }
        case .heater:
            if let heater = try? Heater(from: decoder) {
                self = .heater(heater)
                return
            }
        case .rollerShutter:
            if let rollerShutter = try? RollerShutter(from: decoder) {
                self = .rollerShutter(rollerShutter)
                return
            }
        }
        throw DecodingError.typeMismatch(
            DeviceType.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Wrong type for DeviceType"
            )
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .light(let light):
            try container.encode(light)
        case .heater(let heater):
            try container.encode(heater)
        case .rollerShutter(let rollerShutter):
            try container.encode(rollerShutter)
        }
    }
}
