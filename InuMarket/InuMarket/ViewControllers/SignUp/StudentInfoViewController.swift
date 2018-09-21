//
//  StudentInfoViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 27..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift

class StudentInfoViewController: UIViewController {

    @IBOutlet weak var nameErrorLabel: UILabel!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if nameTextField.text != "" && (idTextField.text?.count)! >= 9 {
            nameErrorLabel.isHidden = true
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetPasswd") as? SetPasswdViewController{
                vc.id = idTextField.text!
                vc.name = nameTextField.text!
                self.navigationController?.show(vc, sender: nil)
            }
        }else{
            nameErrorLabel.isHidden = false
            self.view.makeToast("* 학생 정보를 입력해야 합니다.")

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializing()
        
        // Do any additional setup after loading the view.
    }
    
    func initializing() {
        nameErrorLabel.isHidden = true
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
//        segmentControl.addSubviewToIndicator(customSubview)
        nextButton.addSubview(customSubview)
    }

}
