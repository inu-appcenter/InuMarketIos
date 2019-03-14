//
//  UIFontExtension.swift
//  InuMarket
//
//  Created by 김성은 on 14/03/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum NotoSansCJKKrType: String {
        case bold = "NotoSansChakma-Bold"
        case medium = "NotoSansChakma-Medium"
        case regular = "NotoSansChakma-Regular"
    }
    
    static func NotoSansCJKKr(type: NotoSansCJKKrType, size: CGFloat) -> UIFont {
        if let font = UIFont(name: type.rawValue, size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
