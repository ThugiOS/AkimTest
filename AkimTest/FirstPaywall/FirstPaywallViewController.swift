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
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    private let closeButton: UIButton = {
        $0.layer.cornerRadius = 21
        $0.setImage(UIImage(named: "x"), for: .normal)
        $0.backgroundColor = .closeCircle
        return $0
    }(UIButton())
    
//    private let mainLabel: UILabel = {
//        $0.textColor = .white
//        $0.textAlignment = .center
//        $0.font = .systemFont(ofSize: 39, weight: .regular)
//        $0.text = String(localized: "Get Premium Access")
//        return $0
//    }(UILabel())
    
    private let mainLabel = CustomView()
    
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
        view.addSubview(closeButton)
        view.addSubview(mainLabel)
        view.addSubview(continueButton)
        
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(restoreButton)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
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
}

// MARK: - Constraints
private extension FirstPaywallViewController {
    func setConstraints() {
        let screenHeight = UIScreen.main.bounds.height
        
        let closeButtonTopOffset: Int
        let continueButtonBottomOffset: Int
        
        if screenHeight <= 667 { // Height of iPhone SE
            closeButtonTopOffset = 30
            continueButtonBottomOffset = -55
        } else {
            closeButtonTopOffset = 59
            continueButtonBottomOffset = -75
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.trailing.equalToSuperview().offset(-21)
            make.top.equalToSuperview().offset(closeButtonTopOffset)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
