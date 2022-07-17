//
//  ThemedTableView.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit

class ThemedTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(setCurrentTheme))
        setCurrentTheme()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc private func setCurrentTheme() {
        handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {
        backgroundColor = theme.backgroundColor
    }

}
