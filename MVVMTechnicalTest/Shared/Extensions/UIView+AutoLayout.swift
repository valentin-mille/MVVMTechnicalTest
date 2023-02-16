//
//  UIView+AutoLayout.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

extension UIView {
    func autoFit() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        autoFitHorizontally(superview: superview)
        autoFitVertically(superview: superview)
    }

    private func autoFitHorizontally(superview: UIView) {
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }

    private func autoFitVertically(superview: UIView) {
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public init(
        wrappedValue: T
    ) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
