//
//  PhoneChangeViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 6..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class PhoneChangeViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var oldPhoneLabel: UILabel!
    @IBOutlet weak var newPhoneTextField: UITextField!
    @IBOutlet weak var verifiedButton: UIButton!
    
    @IBAction func verifiedButtonClicked(_ sender: Any) {
        if (newPhoneTextField.text?.count)! == 11{
            // 에러메시지 숨기기
            errorLabel.isHidden = true
            
            // alert
            let alertController = UIAlertController(title: "새로운 전화번호로 변경 완료.", message: "확인을 누르면 종료됩니다.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            
            let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(cancelButton)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else{ // 번호가 11자리가 아닐때
            
            errorLabel.isHidden = false
            newPhoneTextField.text = nil
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oldPhoneLabel.text = self.appDelegate.userInfo?.tel 
        initializing()
        
    }


    func initializing() {
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        verifiedButton.addSubview(customSubview)
    }
}
