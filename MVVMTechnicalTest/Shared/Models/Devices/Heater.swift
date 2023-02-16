//
//  Heater.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

struct Header: Device, Configurable {
    let id: UInt
    let deviceName: String
    let productType: String
    let mode: Bool

    let temperature: Int
}
