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
    
    private let mainLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 39, weight: .regular)
        $0.text = String(localized: "Get Premium Access")
        return $0
    }(UILabel())
    
    private let continueButton: UIButton = {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .red
        $0.tintColor = .white
        $0.setTitle("Continue", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
        view.addSubview(mainLabel)
        view.addSubview(continueButton)
    }
}

// MARK: - Constraints
private extension FirstPaywallViewController {
    func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
