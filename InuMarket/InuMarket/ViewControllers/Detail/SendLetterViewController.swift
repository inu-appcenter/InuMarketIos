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
import Toast_Swift

class SendLetterViewController: UIViewController {
    
    //MARK: properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var productImageSlide : [KingfisherSource] = []
    
    var model : NetworkModel?
    var sendResult : AnsResult?
    // product info
    var productName: String = ""
    var sellerId: String = ""
    var productId: String = ""
    // my info
    var userName: String = ""
    var userPhone : String = ""
    var userId : String = ""
    
    //MARK: IBOutlet
    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var productImg: ImageSlideshow!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myPhoneNumLabel: UILabel!
    
    @IBOutlet weak var cancelButtonView: UIView!
    @IBOutlet weak var sendButtonView: UIView!
    
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        sendReady()
        letterView.layer.cornerRadius = 8
        productImg.layer.cornerRadius = 8
        productImg.setImageInputs(self.productImageSlide)
        productImg.slideshowInterval = 2.0
        productNameLabel.text = productName
        myPhoneNumLabel.text = "전화번호 :  \(userPhone)"
        myNameLabel.text = "내 이름:  \(userName)"
        
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
        self.model?.letterSend(productId: productId, custId: userId, sellerId: sellerId, productName: productName)
        self.view.makeToastActivity(.center)
        
        self.view.makeToast("전송중입니다.")
        
        let time = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: time) {
            if self.sendResult?.ans == true{
                 self.appDelegate.userInfo?.letter = (self.appDelegate.userInfo?.letter)! + 1
                self.dismiss(animated: false, completion: {
                    checkLetterVC.productImageSlide = self.productImageSlide
                    pvc?.present(checkLetterVC, animated: true, completion: nil)
                })
            }
        }
    }
    
    func sendReady(){
        userPhone = (self.appDelegate.userInfo?.tel)!
        userName = (self.appDelegate.userInfo?.name)!
        userId = (self.appDelegate.userInfo?.id)!
    }
}

extension SendLetterViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "letterSendSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
                self.sendResult = obj
            }
        }
    }
    
    func networkFail(code: String) {
        if code == "letterSendError"{
            
        }
    }
    
    
}
