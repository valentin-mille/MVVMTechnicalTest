//
//  Heater.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

struct Heater: Device, Configurable {
    let id: UInt
    let deviceName: String
    let productType: String
    let mode: Bool

    let temperature: Int

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
        temperature = try values.decode(Int.self, forKey: .temperature)
    }
}
