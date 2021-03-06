//
//  ThemeManagee.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import Foundation
import RxSwift

struct ThemeManager {
    static let styleStatusKey = "styleStatusKey"
    static var styleHasBeenChanged = PublishSubject<Void>()
    
    static var currentTheme: Theme {
        return isDarkMode() ? .dark : .light
    }
    
    static func isDarkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: styleStatusKey)
    }
    
    static func enableDarkMode() {
        UserDefaults.standard.set(true, forKey: styleStatusKey)
        styleHasBeenChanged.onNext(())
    }
    
    static func disableDarkMode() {
        UserDefaults.standard.set(false, forKey: styleStatusKey)
        styleHasBeenChanged.onNext(())
    }
}
