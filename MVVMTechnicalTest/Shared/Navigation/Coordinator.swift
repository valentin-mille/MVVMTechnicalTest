//
//  Coordinator.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

protocol CoordinatorStep {

}

protocol Coordinator: AnyObject {

    typealias CoordinatorDidFinish = (((any Coordinator)?) -> Void)?

    associatedtype Router = NavigationRouter
    associatedtype CoordinatorStep

    var router: Router { get }
    var didFinish: CoordinatorDidFinish { get }
    var children: [any Coordinator] { get set }
    var currentStep: CoordinatorStep? { get set }

    init(with router: Router, didFinish: CoordinatorDidFinish)
    func start()
    func addChild(child: any Coordinator)
    func removeChild(_ child: (any Coordinator)?)

}

extension Coordinator {

    func addChild(child: any Coordinator) {
        children.append(child)
    }

    func removeChild(_ child: (any Coordinator)?) {
        for (index, coordinator) in children.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }

}
