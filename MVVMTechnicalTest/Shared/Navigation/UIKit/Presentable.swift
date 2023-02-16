//
//  Presentable.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

protocol Presentable: AnyObject {
    func getPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    func getPresentable() -> UIViewController {
        return self
    }
}
