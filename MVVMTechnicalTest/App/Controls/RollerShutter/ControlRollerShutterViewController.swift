//
//  ControlRollerShutterViewController.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation
import UIKit

private enum Constants {
    static let stackViewSpacing: CGFloat = 10
    static let imageStatusSize = CGSize(width: 50, height: 50)
}

final class ControlRollerShutterViewController: UIViewController {

    var viewModel: ControlRollerShutterViewModel

    private lazy var stackViewHorizontal = createStackView()
    private lazy var labelStatus = createLabelStatus()
    private lazy var imageStatus = createImageStatusView()
    private lazy var slider = createSlider()

    init(
        viewModel: ControlRollerShutterViewModel
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
        stackViewHorizontal.addArrangedSubview(slider)
        view.addSubview(stackViewHorizontal)
    }

    private func setupConstraints() {
        imageStatus.setHeight(to: 200)
        labelStatus.setHeight(to: 50)
        slider.setWidth(to: view.frame.width)
        stackViewHorizontal.autoFit(inSafeArea: true)
    }

    @objc
    private func didTouchSlider(sender: UISlider) {
        self.viewModel.configureDevice(value: sender.value)
        labelStatus.text = self.viewModel.statusText
    }
}

extension ControlRollerShutterViewController {
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
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func createSlider() -> UISlider {
        let slider = UISlider()
        let device = viewModel.device
        slider.maximumValue = Float(device.getMaxValue())
        slider.minimumValue = Float(device.getMinValue())
        slider.value = Float(device.getCurrentValue())
        slider.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
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
