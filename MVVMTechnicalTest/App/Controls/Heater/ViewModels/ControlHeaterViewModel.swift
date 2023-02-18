//
//  ControlHeaterViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation

final class ControlHeaterViewModel: ControlViewModel {

    typealias DeviceControlled = Heater

    var device: DeviceControlled
    var statusText: String {
        self.device.getStatus()
    }

    init(
        device: Heater
    ) {
        self.device = device
    }
}

// MARK: - ControlConfigurable

extension ControlHeaterViewModel: ControlConfigurable {
    func configureDevice(value: Float) {
        guard value > 0 else { return }
        let step: Float = 0.5
        let newValue: Float = round(value / step) * step
        self.device.setCurrentValue(newValue: newValue)
    }
}

// MARK: - ControlActivable

extension ControlHeaterViewModel: ControlActivable {
    func activateDevice(isActivated: Bool) {
        self.device.mode = isActivated
    }
}
