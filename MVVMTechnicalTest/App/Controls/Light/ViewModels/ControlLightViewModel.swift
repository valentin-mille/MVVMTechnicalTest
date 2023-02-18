//
//  ControlLightViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation

final class ControlLightViewModel: ControlViewModel {

    typealias DeviceControlled = Light

    var device: DeviceControlled
    var statusText: String {
        self.device.getStatus()
    }

    init(
        device: Light
    ) {
        self.device = device
    }
}

// MARK: - ControlConfigurable

extension ControlLightViewModel: ControlConfigurable {
    func configureDevice(value: Float) {
        self.device.setCurrentValue(newValue: value)
    }
}

// MARK: - ControlActivable

extension ControlLightViewModel: ControlActivable {
    func activateDevice(isActivated: Bool) {
        self.device.mode = isActivated
    }
}
