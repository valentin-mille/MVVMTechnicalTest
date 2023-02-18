//
//  ControlVerticalViewController.swift
//  MVVMTechnicalTest
//
//  Created by Valentin Mille on 2/18/23.
//

import Foundation
import UIKit

private enum Constants {
    static let stackViewSpacing: CGFloat = 20
}

final class ControlVerticalViewController: UIViewController {

    var viewModel: ControlViewModel

    private lazy var stackViewHorizontal = createStackView()
    private lazy var imageStatus = createImageStatusView()
    private lazy var labelStatus = createLabelStatus()
    private lazy var slider = createSlider()

    init(
        viewModel: ControlViewModel
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelStatus()
    }

    private func buildViewHierarchy() {
        stackViewHorizontal.addArrangedSubview(imageStatus)
        stackViewHorizontal.addArrangedSubview(slider)
        view.addSubview(stackViewHorizontal)
    }

    private func setupConstraints() {
        imageStatus.setHeight(to: 200)
        labelStatus.setHeight(to: 50)
        slider.setHeight(to: 50)
        slider.autoFitLeading(spacing: 20)
        slider.setWidth(to: view.frame.width)
        stackViewHorizontal.autoFit(inSafeArea: true)
    }

    @objc
    private func didTouchSlider(sender: UISlider) {
        guard let configurable = self.viewModel.device as? Configurable,
            sender.value > 0
        else { return }
        configurable.setCurrentValue(newValue: UInt(sender.value))
        updateLabelStatus()
    }

    private func updateLabelStatus() {
        guard let configurable = viewModel.device as? Configurable else { return }
        labelStatus.text = "The \(viewModel.device.deviceName) is at \(configurable.getCurrentValue())"
    }
}

extension ControlVerticalViewController {
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

    private func createSlider() -> UISlider {
        let slider = UISlider()

        if let configurable = viewModel.device as? Configurable {
            slider.maximumValue = Float(configurable.getMaxValue())
            slider.minimumValue = Float(configurable.getMinValue())
            slider.value = Float(configurable.getCurrentValue())
            slider.transform = CGAffineTransform(rotationAngle: CGFloat(-CGFloat.pi / 2))
        } else {
            slider.isHidden = true
        }

        slider.addTarget(self, action: #selector(self.didTouchSlider), for: .allTouchEvents)
        return slider
    }

    private func createLabelStatus() -> UILabel {
        let label = UILabel()
        if viewModel.device.isConfigurable() {
            label.font = .systemFont(ofSize: 16, weight: .bold)
        } else {
            label.isHidden = true
        }
        return label
    }
}
