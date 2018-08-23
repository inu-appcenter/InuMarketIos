//
//  CheckLetterViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 10..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

class CheckLetterViewController: UIViewController {
    
    //MARK: properties
    var productImageSlide : [KingfisherSource] = []
    var productName: String = ""
    var sellerName: String = ""
    var sellerPhone: String = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: IBOutlet
    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var productImg: ImageSlideshow!
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
        productImg.setImageInputs(self.productImageSlide)
        productImg.slideshowInterval = 2.0

        productName = (self.appDelegate.detailList?.productName)!
        sellerPhone = (self.appDelegate.detailList?.sellerPhone)!
        sellerName = (self.appDelegate.detailList?.sellerName)!
        
        sellerNameLabel.text = "판매자 이름 : \(sellerName)"
        sellerPhoneNumLabel.text = "전화번호 : \(sellerPhone)"
        productNameLabel.text = "상품명: \(productName)"
        let doneGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doneTapped(_:)))
        doneButtonView.addGestureRecognizer(doneGesture)
    }
    
    //MARK: Methods
    @objc private func doneTapped(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
