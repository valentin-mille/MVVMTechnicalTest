//
//  Light.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

struct Light: Device, Configurable {
    let id: UInt
    let deviceName: String
    let productType: String
    let mode: Bool

    let intensity: UInt
}
