//
//  ThemedNavigationController.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit

class ThemedNavigationController: UINavigationController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(setCurrentTheme))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentTheme()
    }

    @objc private func setCurrentTheme() {
        handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {
        navigationBar.barTintColor = theme.backgroundColor
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.labelColor]
    }

}
