//
//  AnimatedGradientButton.swift
//  AkimTest
//
//  Created by Никитин Артем on 16.05.24.
//

import UIKit

final class AnimatedGradientButton: UIButton {
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        gradientLayer.colors = [UIColor.gradientFirstPaywall.cgColor, UIColor.mainFirstPaywall.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.7)
        
        layer.insertSublayer(gradientLayer, at: 0)

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = [UIColor.mainFirstPaywall.cgColor, UIColor.gradientFirstPaywall.cgColor]
        animation.duration = 3
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
