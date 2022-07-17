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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(setCurrentTheme))
        setCurrentTheme()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUserInterfaceStyle()
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
