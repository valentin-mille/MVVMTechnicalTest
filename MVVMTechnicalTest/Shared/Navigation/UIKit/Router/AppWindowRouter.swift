//
//  AppWindowRouter.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

final class AppWindowRouter: WindowRouter {

    // MARK: - Properties

    let window: UIWindow

    // MARK: - Init

    init(
        window: UIWindow
    ) {
        self.window = window
    }

    // MARK: - Methods

    func setRoot(_ presentable: Presentable) {
        let viewController = presentable.getPresentable()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

}
