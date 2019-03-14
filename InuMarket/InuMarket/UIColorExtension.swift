//
//  UIColorExtension.swift
//  InuMarket
//
//  Created by 김성은 on 14/03/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(ored: CGFloat, ogreen: CGFloat, oblue: CGFloat, alpha: CGFloat) {
        self.init(red: ored / 255,
                  green: ogreen / 255,
                  blue: oblue / 255,
                  alpha: alpha)
    }
    
    static let MainColor = UIColor.init(ored: 241, ogreen: 109, oblue: 103, alpha: 1.0)
    static let TextColor = UIColor.init(ored: 71, ogreen: 80, oblue: 88, alpha: 1.0)
    static let AlertColor = UIColor.init(ored: 251, ogreen: 58, oblue: 47, alpha: 1.0)
}
