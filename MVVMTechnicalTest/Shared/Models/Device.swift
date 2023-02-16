//
//  Device.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation

protocol Device {
    var id: UInt { get }
    var deviceName: String { get }
    var productType: String { get }
}

protocol Configurable {
    var mode: Bool { get }
}
