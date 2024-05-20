//
//  SecondPaywallButton.swift
//  AkimTest
//
//  Created by Никитин Артем on 20.05.24.
//

import UIKit
import SnapKit

final class SecondPaywallButton: UIButton {
    private let periodLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let priceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let descriptionPriceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
        $0.alpha = 0.5
        return $0
    }(UILabel())
    
    init(frame: CGRect, mainLabel: String, price: String, descriptionPrice: String, description: String? = nil) {
        super.init(frame: frame)
        setupViews(mainLabel: mainLabel, price: price, descriptionPrice: descriptionPrice, description: description)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews(mainLabel: String, price: String, descriptionPrice: String, description: String?) {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        
        addSubview(periodLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(descriptionPriceLabel)
        
        periodLabel.text = mainLabel
        priceLabel.text = price
        descriptionPriceLabel.text = descriptionPrice
        descriptionLabel.text = description ?? ""
        
        periodLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(periodLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(periodLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        descriptionPriceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(priceLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}
