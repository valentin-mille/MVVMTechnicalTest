//
//  HomeCoordinator.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

enum HomeCoordinatorSteps: CoordinatorStep {
}

final class HomeCoordinator: Coordinator {

    typealias ChildCooddrdinator = Coordinator
    typealias CoordinatorStep = HomeCoordinatorSteps
    typealias Router = NavigationControllerRouter

    // MARK: - Properties

    var currentStep: CoordinatorStep?
    let router: Router
    var children: [any Coordinator]
    let didFinish: CoordinatorDidFinish

    // MARK: - Init

    init(
        with router: Router,
        didFinish: CoordinatorDidFinish
    ) {
        self.router = router
        self.didFinish = didFinish
        self.children = []
    }

    // MARK: - Methods

    func start() {
        let homeVC = createHomeViewController()
        self.router.push(homeVC, animated: true, onDismiss: nil)
    }

}

extension HomeCoordinator: HomeViewControllerFlowDelegate {
    func didSelect(device selectedDevice: Device) {
        let viewModel = ControlViewModel(device: selectedDevice)
        let controlVC = ControlHorizontalViewController(viewModel: viewModel)

        self.router.push(controlVC, animated: true, onDismiss: nil)
    }
}

extension HomeCoordinator {

    private func createHomeViewController() -> UIViewController {
        let homeVC = HomeViewController()

        homeVC.flowDelegate = self
        return homeVC
    }
}
