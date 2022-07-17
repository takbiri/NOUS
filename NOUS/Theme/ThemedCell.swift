//
//  ThemedTableViewCell.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit

class ThemedCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ThemeManager.addDarkModeObserver(to: self, selector: #selector(setCurrentTheme))
        setCurrentTheme()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc private func setCurrentTheme() {
        handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {}
}
