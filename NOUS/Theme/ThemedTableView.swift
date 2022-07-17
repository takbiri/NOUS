//
//  ThemedTableView.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit
import RxSwift

class ThemedTableView: UITableView {
    
    let bag = DisposeBag()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        ThemeManager.styleHasBeenChanged.subscribe { _ in
            self.handleCurrentTheme(theme: ThemeManager.currentTheme)
        }.disposed(by: self.bag)
        
        self.handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {
        backgroundColor = theme.backgroundColor
    }

}
