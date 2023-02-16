//
//  WindowRouter.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import Foundation
import UIKit

protocol WindowRouter {

    var window: UIWindow { get }

    init(window: UIWindow)
    func setRoot(_ presentable: Presentable)

}
