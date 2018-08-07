//
//  SetPasswdViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 27..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class SetPasswdViewController: UIViewController {

    var name : String = ""
    var id : String = ""
    
    @IBOutlet weak var passwdTextField: UITextField!
    
    @IBOutlet weak var checkPasswdTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if (passwdTextField.text?.count)! >= 8 && passwdTextField.text == checkPasswdTextField.text{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetPhone") as? SetPhoneViewController{
                vc.passwd = passwdTextField.text!
                vc.id = id
                vc.name = name
                self.navigationController?.show(vc, sender: nil)
            }
        }else {
            print("ㅗ")
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
