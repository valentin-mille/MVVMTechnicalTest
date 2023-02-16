//
//  HomeViewController.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

final class HomeViewController: UIViewController {

    private lazy var tableView: UITableView = createTableView()
    private lazy var viewModel = createHomeViewModel()
    private let label = UILabel()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildViewHierarchy()
        self.setupConstraints()
        viewModel.loadDeviceList()
    }

    private func buildViewHierarchy() {
        label.text = "Hello World"
        view.backgroundColor = .white
        view.addSubview(label)
    }

    private func setupConstraints() {
        label.autoFit()
    }

}

// MARK: - UITableViewDataSource

//extension HomeViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

}

extension HomeViewController {
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        //        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        return UITableView()
    }

    private func createHomeViewModel() -> HomeViewModel {
        return HomeViewModel(service: DeviceService())
    }

    //    private func createDefaultModel() -> DeviceList {
    //        let model = DeviceList(devices: [
    //            Header(id: <#T##UInt#>, deviceName: <#T##String#>, productType: <#T##String#>, mode: <#T##Bool#>, temperature: <#T##Int#>)
    //        ])
    //    }
}
