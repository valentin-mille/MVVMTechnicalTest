//
//  AppCoordinator.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

enum AppCoordinatorStep: CoordinatorStep {
    case loading
    case home
}

final class AppCoordinator: Coordinator {

    typealias CoordinatorStep = AppCoordinatorStep
    typealias Router = AppWindowRouter

    // MARK: - Properties

    let router: Router
    var children: [any Coordinator]
    var currentStep: CoordinatorStep?
    let didFinish: (((any Coordinator)?) -> Void)?

    // MARK: - Init

    init(
        with router: Router,
        didFinish: (((any Coordinator)?) -> Void)?
    ) {
        self.router = router
        self.children = []
        self.currentStep = .loading
        self.didFinish = didFinish
    }

    // MARK: - Methods

    func start() {
        showHome()
    }

    private func showHome() {
        let homeCoordinator = self.createHomeCoordinator()

        self.currentStep = .home
        self.addChild(child: homeCoordinator)
        self.router.setRoot(homeCoordinator.router.navigationController)
        homeCoordinator.start()
    }

}

extension AppCoordinator {

    private func createHomeCoordinator() -> HomeCoordinator {
        let navigationController = createNavigationController()
        let router = NavigationControllerRouter(navigationController: navigationController)
        return HomeCoordinator(with: router, didFinish: self.removeChild)
    }

    private func createNavigationController() -> UINavigationController {
        let navigationVC = UINavigationController()
        navigationVC.navigationBar.prefersLargeTitles = true
        navigationVC.navigationItem.largeTitleDisplayMode = .always
        navigationVC.navigationBar.isHidden = false
        return navigationVC
    }

}
