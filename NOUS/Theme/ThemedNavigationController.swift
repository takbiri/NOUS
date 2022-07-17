//
//  ThemedNavigationController.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit
import RxSwift

class ThemedNavigationController: UINavigationController {
    
    let bag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThemeManager.styleHasBeenChanged.subscribe { _ in
            self.handleCurrentTheme(theme: ThemeManager.currentTheme)
        }.disposed(by: self.bag)
        
        self.handleCurrentTheme(theme: ThemeManager.currentTheme)
    }
    
    func handleCurrentTheme(theme: Theme) {
        navigationBar.barTintColor = theme.backgroundColor
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.labelColor]
    }

}
