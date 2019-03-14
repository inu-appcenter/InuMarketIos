//
//  ViewController.swift
//  InuMarket
//
//  Created by 김성은 on 14/03/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printFonts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("———————————————")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }

}

