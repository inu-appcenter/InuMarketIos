//
//  UploadExplainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 9..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift
import BetterSegmentedControl

class UploadExplainViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var explainTextView: UITextView!
    
    @IBOutlet weak var directDealLocationLabel: UILabel!
    @IBOutlet weak var directDealLocationTextField: UITextField!
    @IBOutlet weak var directDealLocationView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var segmentControll: BetterSegmentedControl!
    var DeliveryCheck : Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        segmentCon()
        
        DeliveryCheck = 1
        directDealLocationTextField.isHidden = false
        directDealLocationLabel.isHidden = false
        directDealLocationView.isHidden = false
        directDealLocationTextField.isEnabled = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func segmentCon() {
        segmentControll.titles = ["판매중", "판매 완료"]
        segmentControll.layer.borderWidth = 1.0
        segmentControll.layer.borderColor = UIColor(red: 238/255, green: 84/255, blue: 44/255, alpha: 1.0).cgColor
        
        
    }
    
    //    세그먼트 값 시경시
    @IBAction func SegmentControlValueChanged(_ sender: BetterSegmentedControl) {
        //        index 는 0부터 시작
        if sender.index == 0{
            DeliveryCheck = 1
            directDealLocationTextField.isHidden = false
            directDealLocationLabel.isHidden = false
            directDealLocationView.isHidden = false
            directDealLocationTextField.isEnabled = true
            
            
        }else {
            DeliveryCheck = 2
            directDealLocationTextField.text = nil
            directDealLocationTextField.isHidden = true
            directDealLocationLabel.isHidden = true
            directDealLocationView.isHidden = true
            directDealLocationTextField.isEnabled = false
            
            
        }
        
        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        switch DeliveryCheck {
        case 1:
            if explainTextView.text != "" && directDealLocationTextField.text != ""
            {
                print("넘어간당")
                if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadPhoto") as? UploadPhotoViewController{
                    self.navigationController?.show(vc, sender: nil)
                }
            }else{
                self.view.makeToast("* 상품 설명과 거래 방식 입력해야 합니다.")
                
            }
            break
        case 2:
            if explainTextView.text != "" {
                print("통과")
                if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadPhoto") as? UploadPhotoViewController{
                    self.navigationController?.show(vc, sender: nil)
                }
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
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        nextButton.addSubview(customSubview)
    }
}
