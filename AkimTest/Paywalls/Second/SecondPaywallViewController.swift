//
//  SecondPaywallViewController.swift
//  AkimTest
//
//  Created by Никитин Артем on 20.05.24.
//

import UIKit
import SnapKit

final class SecondPaywallViewController: UIViewController {
    // MARK: - Enums
    private enum SelectedPlan {
        case oneYear
        case oneWeek
    }
    
    // MARK: - Properties
    private var selectedPlan: SelectedPlan = .oneYear {
        didSet {
            updateSelectedPlanUI()
        }
    }
    
    // MARK: - UI Components
    private let backgroundView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "mainView")
        return $0
    }(UIImageView())
    
    private let mainLabel: UILabel = {
        $0.textColor = .label
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 39, weight: .regular)
        $0.numberOfLines = 2
        $0.text = String(localized: "Join the enjoyable learning")
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.textColor = .label
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 3
        $0.text = String(localized: "Enjoy the lessons with your favorite app.\nCancel anytime.")
        return $0
    }(UILabel())
    
    private let closeButton: UIButton = {
        $0.layer.cornerRadius = 21
        $0.setImage(UIImage(named: "x"), for: .normal)
        $0.backgroundColor = .closeCircle
        return $0
    }(UIButton())
    
    private let bestChoiceView: UIView = {
        $0.backgroundColor = .mainSecondPaywall
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    private let bestChoiceLabel: UILabel = {
        $0.text = "Best choice"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 10, weight: .semibold)
        return $0
    }(UILabel())
    
    private let twelveMonthButton = SecondPaywallButton(frame: .zero,
                                                        mainLabel: String(localized: "1 year"),
                                                        price: String(localized: "$99.99"),
                                                        descriptionPrice: String(localized: "$1.96 / week"),
                                                        description: String(localized: "7-day free trial"))
    
    private let twelveWeeksButton = SecondPaywallButton(frame: .zero,
                                                        mainLabel: String(localized: "1 week"),
                                                        price: String(localized: "$2.99"),
                                                        descriptionPrice: String(localized: "$3.3 / week"))
    
    private let continueButton: UIButton = {
        $0.setTitle(String(localized: "Continue"), for: .normal)
        $0.backgroundColor = .mainSecondPaywall
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        return $0
    }(UIButton())
    
    private let termsButton: UIButton = {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(String(localized: "Terms"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UIButton())
    
    private let privacyButton: UIButton = {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(String(localized: "Privacy"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UIButton())
    
    private let restoreButton: UIButton = {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(String(localized: "Restore"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        updateSelectedPlanUI()
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundView)
        view.addSubview(closeButton)
        view.addSubview(mainLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(twelveMonthButton)
        view.addSubview(bestChoiceView)
        bestChoiceView.addSubview(bestChoiceLabel)
        view.addSubview(twelveWeeksButton)
        view.addSubview(continueButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(restoreButton)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        twelveMonthButton.addTarget(self, action: #selector(oneYearButtonTapped), for: .touchUpInside)
        twelveWeeksButton.addTarget(self, action: #selector(oneWeekButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - UI Update
    private func updateSelectedPlanUI() {
        switch selectedPlan {
        case .oneYear:
            twelveMonthButton.layer.borderColor = UIColor.mainSecondPaywall.cgColor
            twelveMonthButton.backgroundColor = UIColor.white.withAlphaComponent(0.06)
            bestChoiceView.backgroundColor = UIColor.mainSecondPaywall
            
            twelveWeeksButton.backgroundColor = UIColor.mainSecondPaywall
            twelveWeeksButton.layer.borderColor = UIColor.borderSecondPaywall.cgColor
            twelveWeeksButton.backgroundColor = UIColor.white.withAlphaComponent(0.17)
        case .oneWeek:
            twelveMonthButton.layer.borderColor = UIColor.borderSecondPaywall.cgColor
            twelveMonthButton.backgroundColor = UIColor.white.withAlphaComponent(0.17)
            
            twelveWeeksButton.backgroundColor = UIColor.white.withAlphaComponent(0.06)
            twelveWeeksButton.layer.borderColor = UIColor.mainSecondPaywall.cgColor
            bestChoiceView.backgroundColor = UIColor.borderSecondPaywall
        }
    }
    
    @objc
    private func continueButtonTapped() {
        continueButton.animateButton()
        print("Continue with \(selectedPlan)")
    }
    
    @objc
    private func closeButtonTapped() {
        closeButton.animateButton()
        Settings.setLastShownPaywall(.second)
        let wallpaperVC = WallpaperViewController()
        wallpaperVC.modalPresentationStyle = .fullScreen
        wallpaperVC.modalTransitionStyle = .crossDissolve
        present(wallpaperVC, animated: true, completion: nil)
    }
    
    @objc
    private func oneWeekButtonTapped() {
        selectedPlan = .oneWeek
    }
    
    @objc
    private func oneYearButtonTapped() {
        selectedPlan = .oneYear
    }
}

// MARK: - Constraints
private extension SecondPaywallViewController {
    func setConstraints() {
        let screenHeight = UIScreen.main.bounds.height
        
        let closeButtonTopOffset: Int
        let continueButtonBottomOffset: Int
        let mainViewTopOffset: Int
        let mainViewLeadingTrailingOffset: Int
        
        if screenHeight <= 667 { // Height of iPhone 8, SE 2-3 etc.
            closeButtonTopOffset = 30
            mainViewTopOffset = 0
            mainViewLeadingTrailingOffset = 50
            continueButtonBottomOffset = -55
        } else {
            closeButtonTopOffset = 59
            mainViewTopOffset = 102
            mainViewLeadingTrailingOffset = 19
            continueButtonBottomOffset = -75
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.leading.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(closeButtonTopOffset)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(mainViewLeadingTrailingOffset)
            make.trailing.equalToSuperview().offset(-mainViewLeadingTrailingOffset)
            make.top.equalToSuperview().offset(mainViewTopOffset)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
            make.leading.equalTo(19)
            make.trailing.equalTo(-19)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(twelveMonthButton.snp.top).offset(-12)
            make.leading.equalTo(19)
            make.trailing.equalTo(-19)
        }
        
        bestChoiceView.snp.makeConstraints { make in
            make.centerY.equalTo(twelveMonthButton.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(14)
            make.trailing.equalTo(twelveMonthButton).offset(-8)
        }
        
        bestChoiceLabel.snp.makeConstraints { make in
            make.center.equalTo(bestChoiceView)
        }
        
        twelveMonthButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-21)
            make.height.equalTo(65)
            make.bottom.equalTo(twelveWeeksButton.snp.top).offset(-10)
        }
        
        twelveWeeksButton.snp.makeConstraints { make in
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

