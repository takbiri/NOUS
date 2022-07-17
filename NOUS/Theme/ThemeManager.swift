//
//  ThemeManagee.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import Foundation

struct ThemeManager {
    static let isDarkModeKey = "isDarkMode"
    
    static var currentTheme: Theme {
        return isDarkMode() ? .dark : .light
    }
    
    static func isDarkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: isDarkModeKey)
    }
    
    static func enableDarkMode() {
        UserDefaults.standard.set(true, forKey: isDarkModeKey)
        NotificationCenter.default.post(name: .systemInterfaceHasChanged, object: nil)
    }
    
    static func disableDarkMode() {
        UserDefaults.standard.set(false, forKey: isDarkModeKey)
        NotificationCenter.default.post(name: .systemInterfaceHasChanged, object: nil)
    }

    static func addDarkModeObserver(to observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .systemInterfaceHasChanged, object: nil)
    }
}

extension Notification.Name {
    static let systemInterfaceHasChanged = Notification.Name(rawValue: "systemInterfaceHasChanged")
}
