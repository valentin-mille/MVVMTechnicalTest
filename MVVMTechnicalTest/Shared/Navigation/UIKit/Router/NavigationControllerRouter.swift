//
//  NavigationControllerRouter.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

final class NavigationControllerRouter: NSObject, NavigationRouter {

    // MARK: - Properties

    var rootViewController: Presentable? {
        return self.navigationController.viewControllers.first
    }
    let navigationController: UINavigationController
    var onDismissForViewController: [UIViewController: (() -> Void)]

    // MARK: - Init

    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.onDismissForViewController = [:]
        super.init()
        self.navigationController.delegate = self
    }

    // MARK: - Methods

    func push(_ presentable: Presentable, animated: Bool, onDismiss: (() -> Void)?) {
        let viewController = presentable.getPresentable()
        guard viewController is UINavigationController == false else { return }

        if let onDismiss {
            onDismissForViewController[viewController] = onDismiss
        }

        self.navigationController.pushViewController(viewController, animated: animated)
    }

    func present(_ presentable: Presentable, animated: Bool) {
        let viewController = presentable.getPresentable()
        self.navigationController.present(viewController, animated: animated)
    }

    func dismiss(animated: Bool, onDismiss: (() -> Void)?) {
        self.navigationController.dismiss(animated: animated, completion: onDismiss)
    }

    func pop(animated: Bool) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func popToRoot(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    func setRoot(_ presentable: Presentable) {
        let viewController = presentable.getPresentable()
        navigationController.setViewControllers([viewController], animated: false)
    }

    private func runCompletion(for viewController: UIViewController) {
        guard let completion = onDismissForViewController[viewController] else { return }
        completion()
        onDismissForViewController.removeValue(forKey: viewController)
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationControllerRouter: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {

        // Ensure the view controller is popping
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController)
        else {
            return
        }

        runCompletion(for: poppedViewController)
    }

}
