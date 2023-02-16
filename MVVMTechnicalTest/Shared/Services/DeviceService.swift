//
//  DeviceService.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation

protocol DeviceServiceType {

    func getDeviceList(completion: @escaping (Result<DeviceList, APIServiceError>) -> Void)

}

final class DeviceService: DeviceServiceType {

    func getDeviceList(completion: @escaping (Result<DeviceList, APIServiceError>) -> Void) {
        guard let url = URL(string: EndPoints.deviceList) else {
            completion(.failure(.invalidUrl))
            return
        }

        URLSession.shared.resumeDataTask(with: url, withTypedResponse: completion)
    }
}
