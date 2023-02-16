//
//  HomeViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation

final class HomeViewModel {

    private let service: DeviceService

    init(
        service: DeviceService
    ) {
        self.service = service
    }

    func loadDeviceList() {
        self.service.getDeviceList(completion: { result in
            switch result {
            case .success(let deviceList):
                print(deviceList.devices)
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
