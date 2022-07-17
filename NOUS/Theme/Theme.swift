//
//  Theme.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/17/22.
//

import UIKit

struct Theme {
    let labelColor: UIColor
    let backgroundColor: UIColor
    
    static let light = Theme(labelColor: .black, backgroundColor: .white)
    static let dark = Theme(labelColor: .white, backgroundColor: .black)
}
