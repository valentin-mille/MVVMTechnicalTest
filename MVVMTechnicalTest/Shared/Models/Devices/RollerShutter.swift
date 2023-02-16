//
//  RollerShutter.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

struct RollerShutter: Device {
    let id: UInt
    let deviceName: String
    let productType: String

    let position: UInt

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
        position = try values.decode(UInt.self, forKey: .position)
    }
}
