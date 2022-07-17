//
//  ThemedViewController.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit

class ThemedViewController: UIViewController {
    
    var currentStatusBarStyle = UIStatusBarStyle.default
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentStatusBarStyle
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(setCurrentTheme))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUserInterfaceStyle()
        setCurrentTheme()
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
    
    @objc private func setCurrentTheme() {
        handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
        
        currentStatusBarStyle = ThemeManager.isDarkMode() ? .lightContent : .default
        setNeedsStatusBarAppearanceUpdate()
    }
	
}
