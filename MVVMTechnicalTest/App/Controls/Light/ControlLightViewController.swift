//
//  ControlLightViewController.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import UIKit

private enum Constants {
    static let stackViewSpacing: CGFloat = 20
    static let imageStatusSize = CGSize(width: 50, height: 50)
}

final class ControlLightViewController: UIViewController {

    var viewModel: ControlLightViewModel

    private lazy var stackViewHorizontal = createStackView()
    private lazy var labelStatus = createLabelStatus()
    private lazy var imageStatus = createImageStatusView()
    private lazy var switchMode = createSwitchMode()
    private lazy var slider = createSlider()

    init(
        viewModel: ControlLightViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(
        coder: NSCoder
    ) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.device.deviceName
        view.backgroundColor = .white
        self.buildViewHierarchy()
        self.setupConstraints()
    }

    private func buildViewHierarchy() {
        stackViewHorizontal.addArrangedSubview(imageStatus)
        stackViewHorizontal.addArrangedSubview(labelStatus)
        stackViewHorizontal.addArrangedSubview(switchMode)
        stackViewHorizontal.addArrangedSubview(slider)
        view.addSubview(stackViewHorizontal)
    }

    private func setupConstraints() {
        imageStatus.setHeight(to: 200)
        labelStatus.setHeight(to: 50)
        switchMode.setHeight(to: 50)
        slider.setHeight(to: 50)
        slider.autoFitLeading(spacing: 20)
        slider.setWidth(to: view.frame.width)
        stackViewHorizontal.autoFit(inSafeArea: true)
    }

    @objc
    private func didTouchSlider(sender: UISlider) {
        viewModel.configureDevice(value: sender.value)
        labelStatus.text = viewModel.statusText
    }

    @objc
    private func didPressSwitch(sender: UISwitch) {
        viewModel.activateDevice(isActivated: sender.isOn)
        labelStatus.text = viewModel.statusText
        imageStatus.image = viewModel.device.getImage()
    }
}

extension ControlLightViewController {
    private func createImageStatusView() -> UIImageView {
        let image = viewModel.device.getImage()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func createSwitchMode() -> UISwitch {
        let switchMode = UISwitch()
        switchMode.preferredStyle = .sliding
        switchMode.isHidden = !viewModel.device.isActivable()
        switchMode.translatesAutoresizingMaskIntoConstraints = false
        switchMode.setOn(viewModel.device.mode, animated: false)
        switchMode.addTarget(self, action: #selector(self.didPressSwitch), for: .allTouchEvents)
        return switchMode
    }

    private func createSlider() -> UISlider {
        let slider = UISlider()
        let device = viewModel.device
        slider.minimumValueImage = device.getOffImage().withSize(of: Constants.imageStatusSize)
        slider.maximumValueImage = device.getOnImage().withSize(of: Constants.imageStatusSize)
        slider.maximumValue = Float(device.getMaxValue())
        slider.minimumValue = Float(device.getMinValue())
        slider.value = Float(device.getCurrentValue())
        slider.addTarget(self, action: #selector(self.didTouchSlider), for: .allTouchEvents)
        return slider
    }

    private func createLabelStatus() -> UILabel {
        let label = UILabel()
        label.text = viewModel.statusText
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }
}
