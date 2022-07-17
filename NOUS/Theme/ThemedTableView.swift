//
//  ThemedTableView.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit

class ThemedTableView: UITableView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(setCurrentTheme))
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        setCurrentTheme()
    }
    
    @objc private func setCurrentTheme() {
        handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {
        backgroundColor = theme.backgroundColor
    }

}
