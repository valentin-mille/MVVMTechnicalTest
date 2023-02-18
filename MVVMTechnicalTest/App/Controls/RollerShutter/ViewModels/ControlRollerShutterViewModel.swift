//
//  ControlRollerShutterViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation

final class ControlRollerShutterViewModel: ControlViewModel {
    typealias DeviceControlled = RollerShutter

    var device: RollerShutter
    var statusText: String {
        return device.getStatus()
    }

    init(
        device: RollerShutter
    ) {
        self.device = device
    }
}

// MARK: - ControlConfigurable

extension ControlRollerShutterViewModel: ControlConfigurable {
    func configureDevice(value: Float) {
        self.device.setCurrentValue(newValue: value)
    }
}
