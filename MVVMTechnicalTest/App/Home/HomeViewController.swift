//
//  HomeViewController.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/16/23.
//

import UIKit

protocol HomeViewControllerFlowDelegate: AnyObject {
    func didSelect(device selectedDevice: Device)
}

final class HomeViewController: UIViewController {

    // MARK: - Properties

    private lazy var refreshControl = createRefreshControl()
    private lazy var tableView = createTableView()
    private lazy var viewModel = createHomeViewModel()
    private lazy var alertNetwork = createNetworkAlert()

    weak var flowDelegate: HomeViewControllerFlowDelegate?

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.devices
        self.buildViewHierarchy()
        self.setupConstraints()
        loadDevices()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    private func buildViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.autoFit(inSafeArea: false)
    }

    private func configureCell(cell: UITableViewCell, device: Device) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = device.deviceName
        configuration.secondaryText = device.getStatus()
        configuration.image = device.getImage()
        configuration.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        configuration.textProperties.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = configuration
    }

    @objc
    private func loadDevices() {
        guard Reachability.isConnectedToNetwork() else {
            self.refreshControl.endRefreshing()
            self.present(self.alertNetwork, animated: true)
            return
        }
        self.viewModel.loadDeviceList { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }

}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.devices.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = self.viewModel.devices[indexPath.row]
        self.flowDelegate?.didSelect(device: device)
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
        tableView.refreshControl = self.refreshControl
        return tableView
    }

    private func createRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadDevices), for: .valueChanged)
        return refreshControl
    }

    private func createHomeViewModel() -> HomeViewModel {
        let service = DeviceService()
        let mapper = DeviceListDataMapper()
        let viewModel = HomeViewModel(service: service, mapper: mapper)
        return viewModel
    }

    private func createNetworkAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: Strings.Alert.title,
            message: Strings.Alert.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Strings.Alert.Action.ok, style: .default)
        alert.addAction(okAction)
        return alert
    }

}
