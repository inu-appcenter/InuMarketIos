//
//  UploadExplainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 9..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift

class UploadExplainViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var explainTextView: UITextView!
    
    @IBOutlet weak var directDealButton: UIButton!
    @IBOutlet weak var deliveryDealButton: UIButton!
    
    @IBOutlet weak var directDealLocationLabel: UILabel!
    @IBOutlet weak var directDealLocationTextField: UITextField!
    @IBOutlet weak var directDealLocationView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var DeliveryCheck : Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func directDealButtonClicked(_ sender: Any) {
        DeliveryCheck = 1
        directDealButton.backgroundColor = UIColor(red: 69/255, green: 222/255, blue: 157/255, alpha: 1.0)
        deliveryDealButton.isSelected = false
        deliveryDealButton.backgroundColor = UIColor(red: 238/255, green: 240/255, blue: 242/255, alpha: 1.0)
        
        directDealLocationTextField.isHidden = false
        directDealLocationLabel.isHidden = false
        directDealLocationView.isHidden = false
        directDealLocationTextField.isEnabled = true
        
        
    }
    
    @IBAction func deliveryDealButtonClicked(_ sender: Any) {
        DeliveryCheck = 2
        deliveryDealButton.backgroundColor = UIColor(red: 69/255, green: 222/255, blue: 157/255, alpha: 1.0)
        directDealButton.isSelected = false
        directDealButton.backgroundColor = UIColor(red: 238/255, green: 240/255, blue: 242/255, alpha: 1.0)
        
        directDealLocationTextField.text = nil
        directDealLocationTextField.isHidden = true
        directDealLocationLabel.isHidden = true
        directDealLocationView.isHidden = true
        directDealLocationTextField.isEnabled = false
        
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        switch DeliveryCheck {
        case 1:
            if explainTextView.text != "" && directDealLocationTextField.text != ""
            {
                print("넘어간당")
            }else{
                self.view.makeToast("* 상품 설명과 거래 방식 입력해야 합니다.")
                
            }
            break
        case 2:
            if explainTextView.text != "" {
                print("통과")
            }else{
                self.view.makeToast("* 상품 설명과 거래 방식 입력해야 합니다.")
                
            }
            break
        default:
            errorLabel.isHidden = false
            self.view.makeToast("* 상품 설명과 거래 방식 입력해야 합니다.")
        }
    }
    
    func initializing() {
        directDealLocationView.isHidden = true
        directDealLocationLabel.isHidden = true
        directDealLocationTextField.isEnabled = false
        directDealLocationTextField.isHidden = true
        
        explainTextView.layer.borderWidth = 2.0
        explainTextView.layer.borderColor = UIColor(red: 238/255, green: 240/255, blue: 242/255, alpha: 1.0).cgColor
        explainTextView.layer.cornerRadius = 5.0
    }
}
