//
//  NavigationRouter.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

protocol RouterStepAction {}

protocol NavigationRouter: AnyObject {

    var rootViewController: Presentable? { get }

    func push(_ presentable: Presentable, animated: Bool, onDismiss: (() -> Void)?)
    func present(_ presentable: Presentable, animated: Bool)
    func dismiss(animated: Bool, onDismiss: (() -> Void)?)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func setRoot(_ presentable: Presentable)
}
