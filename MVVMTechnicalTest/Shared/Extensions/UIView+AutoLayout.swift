//
//  UIView+AutoLayout.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

extension UIView {

    func autoFit(inSafeArea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        autoFitHorizontally(superview: superview)
        autoFitVertically(superview: superview, inSafeArea: inSafeArea)
    }

    func setHeight(to height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func setWidth(to width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func autoFitLeading(spacing: CGFloat, to view: UIView? = nil) {
        if let view {
            let leadingConstraint = NSLayoutConstraint(
                item: self,
                attribute: .left,
                relatedBy: .equal,
                toItem: view,
                attribute: .left,
                multiplier: 1.0,
                constant: spacing
            )
            addConstraint(leadingConstraint)
        } else {
            guard let superview else { return }
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: spacing).isActive = true
        }
    }

    // MARK: - Privates

    private func autoFitHorizontally(superview: UIView) {
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }

    private func autoFitVertically(superview: UIView, inSafeArea: Bool) {
        if inSafeArea {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
