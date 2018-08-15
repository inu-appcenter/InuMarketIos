//
//  SendLetterViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 10..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher

class SendLetterViewController: UIViewController {
    
    //MARK: properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var productImageSlide : [KingfisherSource] = []
    var productName: String = ""
    var name: String = ""
    var phone : String = ""
    
    //MARK: IBOutlet
    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var productImg: ImageSlideshow!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myPhoneNumLabel: UILabel!
    
    @IBOutlet weak var cancelButtonView: UIView!
    @IBOutlet weak var sendButtonView: UIView!
    
    
    //MARK: life cycle
    override func viewWillAppear(_ animated: Bool) {
        phone = (self.appDelegate.userInfo?.tel)!
        name = (self.appDelegate.userInfo?.name)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterView.layer.cornerRadius = 8
        productImg.layer.cornerRadius = 8
        productImg.setImageInputs(self.productImageSlide)
        productImg.slideshowInterval = 2.0
        productNameLabel.text = productName
        myPhoneNumLabel.text = "전화번호 :  \(phone)"
        myNameLabel.text = "내 이름:  \(name)"

        let cancelGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelTapped(_:)))
        let sendGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendTapped(_:)))
        cancelButtonView.addGestureRecognizer(cancelGesture)
        sendButtonView.addGestureRecognizer(sendGesture)
    }
    
    //MARK: Methods
    @objc private func cancelTapped(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func sendTapped(_ gesture: UITapGestureRecognizer) {
        weak var pvc = self.presentingViewController
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let checkLetterVC = storyboard.instantiateViewController(withIdentifier: "checkLetter") as? CheckLetterViewController else { return }
        dismiss(animated: false, completion: {
//            pvc?.modalPresentationStyle = .custom
            pvc?.present(checkLetterVC, animated: true, completion: nil)
        })
    }
}
