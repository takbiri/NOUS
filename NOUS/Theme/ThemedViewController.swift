//
//  ThemedViewController.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit
import RxSwift

class ThemedViewController: UIViewController {
    
    var currentStatusBarStyle = UIStatusBarStyle.default
    let bag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentStatusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUserInterfaceStyle()
        ThemeManager.styleHasBeenChanged.subscribe { _ in
            self.handleCurrentTheme(theme: ThemeManager.currentTheme)
        }.disposed(by: self.bag)
        
        self.handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        checkForUserInterfaceStyle()
    }

    override var childForStatusBarStyle: UIViewController? {
        return self
    }
    
    private func checkForUserInterfaceStyle() {
        if self.traitCollection.userInterfaceStyle == .dark {
            ThemeManager.enableDarkMode()
        }else {
            ThemeManager.disableDarkMode()
        }
    }
        
    func handleCurrentTheme(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        
        currentStatusBarStyle = ThemeManager.isDarkMode() ? .lightContent : .default
        setNeedsStatusBarAppearanceUpdate()
    }
	
}
