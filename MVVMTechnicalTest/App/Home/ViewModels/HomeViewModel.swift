//
//  HomeViewModel.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation

struct DeviceListDataMapper {
    func createDevices(from deviceListData: DeviceListData) -> [Device] {
        var devices: [Device] = []

        for deviceType in deviceListData.devices {
            switch deviceType {
            case .light(let light):
                devices.append(light)
            case .heater(let heater):
                devices.append(heater)
            case .rollerShutter(let rollerShutter):
                devices.append(rollerShutter)
            }
        }
        return devices
    }
}

final class HomeViewModel {

    // MARK: - Properties

    private let service: DeviceService
    private let mapper: DeviceListDataMapper
    private(set) var devices: [Device] = []

    // MARK: - Init

    init(
        service: DeviceService,
        mapper: DeviceListDataMapper
    ) {
        self.service = service
        self.mapper = mapper
    }

    // MARK: - Methods

    func loadDeviceList(completionHandler: @escaping () -> Void) {
        self.service.getDeviceList(completion: { result in
            switch result {
            case .success(let deviceList):
                self.devices = self.mapper.createDevices(from: deviceList)
                completionHandler()
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
