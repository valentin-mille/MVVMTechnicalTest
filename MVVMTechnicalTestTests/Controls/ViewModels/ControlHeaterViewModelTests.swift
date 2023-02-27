//
//  ControlHeaterViewModel.swift
//  MVVMTechnicalTestTests
//
//  Created by Valentin Mille on 2/27/23.
//

import Foundation
import XCTest

@testable import MVVMTechnicalTest

final class ControlHeaterViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testControlHeaterActivable() throws {
        let model = Heater(
            deviceName: "Radiateur - Chambre",
            productType: "Heater",
            mode: true,
            temperature: 23
        )
        let viewModel = ControlHeaterViewModel(device: model)

        viewModel.activateDevice(isActivated: false)
        XCTAssertTrue(viewModel.device.isActivable())
    }

    func testControlHeaterTemperature() throws {
        let model = Heater(
            deviceName: "Radiateur - Chambre",
            productType: "Heater",
            mode: true,
            temperature: 23
        )
        let viewModel = ControlHeaterViewModel(device: model)

        viewModel.configureDevice(value: 18)
        XCTAssertEqual(viewModel.device.temperature, 18)
    }

}
