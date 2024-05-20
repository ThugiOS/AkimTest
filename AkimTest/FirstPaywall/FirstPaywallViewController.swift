//
//  ViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 15.05.24.
//

import UIKit
import SnapKit

final class FirstPaywallViewController: UIViewController {

    // MARK: - UI Components
    private let backgroundView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "background")
        return $0
    }(UIImageView())
    
    private let gradientView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "gradient")
        return $0
    }(UIImageView())
    
    private let closeButton: UIButton = {
        $0.layer.cornerRadius = 21
        $0.setImage(UIImage(named: "x"), for: .normal)
        $0.backgroundColor = .closeCircle
        return $0
    }(UIButton())
    
    private let mainLabel = CustomView()
    
    private let bestChoiceView: UIView = {
        $0.backgroundColor = .mainFirstPaywall
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())

    private let bestChoiceLabel: UILabel = {
        $0.text = "Best choice"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 10, weight: .semibold)
        return $0
    }(UILabel())
    
    private let oneYearButton = PayButton(frame: .zero,
                                          mainLabel: "1 year",
                                          price: "$99.99",
                                          borderColor: .mainFirstPaywall,
                                          description: "7-day free trial")
    
    private let oneWeekButton = PayButton(frame: .zero,
                                          mainLabel: "1 week",
                                          price: "$2.99",
                                          borderColor: .clear)
    
    private let continueButton: AnimatedGradientButton = {
        $0.setTitle("Continue", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        return $0
    }(AnimatedGradientButton())
    
    private let termsButton: UIButton = {
        $0.tintColor = .white
        $0.setTitle("Terms", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UIButton())
    
    private let privacyButton: UIButton = {
        $0.tintColor = .white
        $0.setTitle("Privacy", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UIButton())
    
    private let restoreButton: UIButton = {
        $0.tintColor = .white
        $0.setTitle("Restore", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(gradientView)
        view.addSubview(closeButton)
        view.addSubview(mainLabel)
        view.addSubview(oneYearButton)
        view.addSubview(bestChoiceView)
        bestChoiceView.addSubview(bestChoiceLabel)
        view.addSubview(oneWeekButton)
        
        oneYearButton.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        oneWeekButton.backgroundColor = UIColor.white.withAlphaComponent(0.17)
        
        view.addSubview(continueButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(restoreButton)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        oneYearButton.addTarget(self, action: #selector(oneYearButtonTapped), for: .touchUpInside)
        oneWeekButton.addTarget(self, action: #selector(oneWeekButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func continueButtonTapped() {
        continueButton.animateButton()
        print("Continue button")
    }
    
    @objc
    private func closeButtonTapped() {
        closeButton.animateButton()
        print("Close button")
    }
    
    @objc
    private func oneWeekButtonTapped() {
        print("One Week")
        oneYearButton.layer.borderColor = UIColor.clear.cgColor
        oneYearButton.backgroundColor = UIColor.white.withAlphaComponent(0.17)
        
        oneWeekButton.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        oneWeekButton.layer.borderColor = UIColor.mainFirstPaywall.cgColor
    }
    
    @objc
    private func oneYearButtonTapped() {
        print("One Year")
        oneYearButton.layer.borderColor = UIColor.mainFirstPaywall.cgColor
        oneYearButton.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        bestChoiceView.backgroundColor = UIColor.mainFirstPaywall
        
        oneWeekButton.backgroundColor = UIColor.mainFirstPaywall
        oneWeekButton.layer.borderColor = UIColor.clear.cgColor
        oneWeekButton.backgroundColor = UIColor.white.withAlphaComponent(0.17)
    }
}

// MARK: - Constraints
private extension FirstPaywallViewController {
    func setConstraints() {
        let screenHeight = UIScreen.main.bounds.height
        
        let closeButtonTopOffset: Int
        let continueButtonBottomOffset: Int
        let mainLabelTopOffset: Int
        
        if screenHeight <= 667 { // Height of iPhone SE
            closeButtonTopOffset = 30
            mainLabelTopOffset = 150
            continueButtonBottomOffset = -55
        } else {
            closeButtonTopOffset = 59
            mainLabelTopOffset = 372
            continueButtonBottomOffset = -75
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView)
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.trailing.equalToSuperview().offset(-21)
            make.top.equalToSuperview().offset(closeButtonTopOffset)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(mainLabelTopOffset)
        }
        
        oneYearButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-21)
            make.height.equalTo(65)
            make.bottom.equalTo(oneWeekButton.snp.top).offset(-10)
        }
        
        bestChoiceView.snp.makeConstraints { make in
            make.centerY.equalTo(oneYearButton.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(14)
            make.trailing.equalTo(oneYearButton).offset(-8)
        }
        
        bestChoiceLabel.snp.makeConstraints { make in
            make.center.equalTo(bestChoiceView)
        }
        
        oneWeekButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-21)
            make.height.equalTo(65)
            make.bottom.equalTo(continueButton.snp.top).offset(-10)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(continueButtonBottomOffset)
            make.leading.equalTo(21)
            make.trailing.equalTo(-21)
            make.height.equalTo(58)
        }

        privacyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(42)
            make.top.equalTo(continueButton.snp.bottom).offset(17)
        }
        
        termsButton.snp.makeConstraints { make in
            make.centerY.equalTo(privacyButton)
            make.width.equalTo(90)
            make.height.equalTo(42)
            make.leading.equalToSuperview().offset(21)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.centerY.equalTo(privacyButton)
            make.width.equalTo(90)
            make.height.equalTo(42)
            make.trailing.equalToSuperview().offset(-21)
        }
    }
}
