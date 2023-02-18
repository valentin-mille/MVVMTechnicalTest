//
//  ControlViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation

protocol ControlViewModel {
    associatedtype DeviceControlled

    var device: DeviceControlled { get set }

    init(device: DeviceControlled)
}

protocol ControlConfigurable {
    func configureDevice(value: Float)
}

protocol ControlActivable {
    func activateDevice(isActivated: Bool)
}
