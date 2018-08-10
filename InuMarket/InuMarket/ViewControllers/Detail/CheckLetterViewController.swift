//
//  CheckLetterViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 10..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class CheckLetterViewController: UIViewController {
    
    //MARK: properties
    
    //MARK: IBOutlet
    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerPhoneNumLabel: UILabel!
    @IBOutlet weak var theCheatButton: UIButton!
    
    @IBOutlet weak var doneButtonView: UIView!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterView.layer.cornerRadius = 8
        productImg.layer.cornerRadius = 8
        theCheatButton.layer.cornerRadius = 8
        productImg.image = UIImage(named: "ractangle4Copy")
        
        let doneGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doneTapped(_:)))
        doneButtonView.addGestureRecognizer(doneGesture)
    }
    
    //MARK: Methods
    @objc private func doneTapped(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
