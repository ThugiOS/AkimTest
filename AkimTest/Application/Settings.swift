//
//  Settings.swift
//  AkimTest
//
//  Created by Никитин Артем on 20.05.24.
//

import Foundation

final class Settings {
    private static let lastShownPaywallKey = "lastShownPaywall"
    
    enum PaywallType: String {
        case first = "FirstPaywall"
        case second = "SecondPaywall"
    }
    
    static func getLastShownPaywall() -> PaywallType {
        let value = UserDefaults.standard.string(forKey: lastShownPaywallKey)
        return PaywallType(rawValue: value ?? PaywallType.first.rawValue) ?? .first
    }
    
    static func setLastShownPaywall(_ paywall: PaywallType) {
        UserDefaults.standard.set(paywall.rawValue, forKey: lastShownPaywallKey)
    }
}

