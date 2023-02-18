//
//  HomeViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation

final class HomeViewModel {

    private let service: DeviceService
    private(set) var deviceList: DeviceList?

    init(
        service: DeviceService
    ) {
        self.service = service
    }

    func loadDeviceList(completionHandler: @escaping () -> Void) {
        self.service.getDeviceList(completion: { result in
            switch result {
            case .success(let deviceList):
                self.deviceList = deviceList
                completionHandler()
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
