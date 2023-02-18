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

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Devices"
        self.buildViewHierarchy()
        self.setupConstraints()
        self.viewModel.loadDeviceList { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func buildViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.autoFit()
    }

    private func configureCell(cell: UITableViewCell, device: Device) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = device.deviceName
        configuration.secondaryText = device.getDisplayString()
        configuration.image = device.getImage()
        configuration.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        configuration.textProperties.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = configuration
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.devices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        let device = self.viewModel.devices[indexPath.row]

        configureCell(cell: cell, device: device)

        return cell
    }

}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

}

extension HomeViewController {
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }

    private func createHomeViewModel() -> HomeViewModel {
        let service = DeviceService()
        let mapper = DeviceListDataMapper()
        let viewModel = HomeViewModel(service: service, mapper: mapper)
        return viewModel
    }

}
