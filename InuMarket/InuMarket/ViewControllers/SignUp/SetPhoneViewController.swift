//
//  SetPhoneViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 31..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift

class SetPhoneViewController: UIViewController {
    
    var name : String = ""
    var id : String = ""
    var passwd : String = ""
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if phoneTextField.text?.count == 11{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Review") as? ReviewViewController{
                vc.tel = phoneTextField.text!
                vc.passwd = passwd
                vc.id = id
                vc.name = name
                self.navigationController?.show(vc, sender: nil)
            }
        }else{
            self.view.makeToast("* 휴대폰 번호를 입력 해야 합니다.")
            print("h")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        // Do any additional setup after loading the view.
    }
    
    
    func initializing() {
        
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        nextButton.addSubview(customSubview)
    }
}
