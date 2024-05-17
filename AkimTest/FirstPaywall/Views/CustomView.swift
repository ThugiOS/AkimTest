//
//  CustomView.swift
//  AkimTest
//
//  Created by Никитин Артем on 17.05.24.
//

import UIKit
import SnapKit

final class CustomView: UIView {
    private let mainLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 39, weight: .regular)
        $0.text = String(localized: "Get Premium Access")
        return $0
    }(UILabel())
    
    // MARK: - Today
    private let lockView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "lock")
        return $0
    }(UIImageView())
    
    private let lockLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.text = String(localized: "Today")
        return $0
    }(UILabel())
    
    private let lockDescriptionLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.text = String(localized: "Enjoy full access to advanced features")
        return $0
    }(UILabel())
    
    // MARK: - 5 days
    private let bellView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "bell")
        return $0
    }(UIImageView())
    
    private let bellLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.text = String(localized: "In 5 days")
        return $0
    }(UILabel())
    
    private let bellDescriptionLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.text = String(localized: "Trial ending reminder")
        return $0
    }(UILabel())
    
    // MARK: - 7 days
    private let starView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "star")
        return $0
    }(UIImageView())
    
    private let starLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.text = String(localized: "In 7 days")
        return $0
    }(UILabel())
    
    private let starDescriptionLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.text = String(localized: "Automatic payment, cancel anytime")
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(mainLabel)
        
        addSubview(lockView)
        addSubview(lockLabel)
        addSubview(lockDescriptionLabel)
        
        addSubview(bellView)
        addSubview(bellLabel)
        addSubview(bellDescriptionLabel)
        
        addSubview(starView)
        addSubview(starLabel)
        addSubview(starDescriptionLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        lockView.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
        }
        
        lockLabel.snp.makeConstraints { make in
            make.top.equalTo(lockView)
            make.leading.equalTo(lockView.snp.trailing).offset(8)
        }
        
        lockDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(lockView)
            make.leading.equalTo(lockView.snp.trailing).offset(8)
        }
        
        bellView.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel)
            make.top.equalTo(lockView.snp.bottom).offset(8)
        }
        
        bellLabel.snp.makeConstraints { make in
            make.top.equalTo(bellView)
            make.leading.equalTo(bellView.snp.trailing).offset(8)
        }
        
        bellDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bellView)
            make.leading.equalTo(bellView.snp.trailing).offset(8)
        }
        
        starView.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel)
            make.top.equalTo(bellView.snp.bottom).offset(8)
        }
        
        starLabel.snp.makeConstraints { make in
            make.top.equalTo(starView)
            make.leading.equalTo(starView.snp.trailing).offset(8)
        }
        
        starDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(starView)
            make.leading.equalTo(starView.snp.trailing).offset(8)
        }
    }
}
