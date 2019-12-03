//
//  SignUpSetPassViewController.swift
//  InuMarket
//
//  Created by 김성은 on 26/10/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class SignUpSetPassViewController: UIViewController {

    var name: String = ""
    var id: String = ""
    var major: String = ""
    
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passCheckTextField: UITextField!
    
    @IBOutlet weak var passErrorLabel: UILabel!
    @IBOutlet weak var checkErrorLabel: UILabel!
    @IBOutlet weak var emptyErrorLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        if passTextField.text!.count >= 8 && passCheckTextField.text == passTextField.text {
            passErrorLabel.isHidden = true
            checkErrorLabel.isHidden = true
            emptyErrorLabel.isHidden = true
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpPhoneViewController") as? SignUpPhoneViewController{
                vc.name = name
                vc.id = id
                vc.major = major
                vc.pass = passTextField.text!
                self.navigationController?.show(vc, sender: nil)
            }
        }
        if passTextField.text == "" || passCheckTextField.text == "" {
            emptyErrorLabel.isHidden = false
        }
    }
    
    @IBAction func passTextFieldChanged(_ sender: Any) {
        if emptyErrorLabel.isHidden == false && passTextField.text != "" {
            emptyErrorLabel.isHidden = true
        }
        
        if passTextField.text!.count < 8 {
            passErrorLabel.isHidden = false
            passErrorLabel.textColor = UIColor.init(named: "orangeyRed")
            passErrorLabel.text = "* 8글자 이상 입력해야 합니다."
        }else {
            passErrorLabel.isHidden = false
            passErrorLabel.textColor = UIColor.init(named: "appleGreen")
            passErrorLabel.text = "* 사용할 수 있는 비밀번호입니다."
        }
        
        //??????????????????????
        if passTextField.text == "" || passCheckTextField.text == "" {
            checkErrorLabel.isHidden = true
        }else if passCheckTextField.text != passTextField.text {
            checkErrorLabel.isHidden = false
            checkErrorLabel.textColor = UIColor.init(named: "orangeyRed")
            checkErrorLabel.text = "* 비밀번호가 일치하지 않습니다."
        }else {
            checkErrorLabel.isHidden = false
            checkErrorLabel.textColor = UIColor.init(named: "appleGreen")
            checkErrorLabel.text = "* 비밀번호가 일치합니다."
        }
    }
    @IBAction func passCheckTextFieldChanged(_ sender: Any) {
        if passTextField.text == "" {
            checkErrorLabel.isHidden = true
        }else if passCheckTextField.text != passTextField.text {
            checkErrorLabel.isHidden = false
            checkErrorLabel.textColor = UIColor.init(named: "orangeyRed")
            checkErrorLabel.text = "* 비밀번호가 일치하지 않습니다."
        }else {
            checkErrorLabel.isHidden = false
            checkErrorLabel.textColor = UIColor.init(named: "appleGreen")
            checkErrorLabel.text = "* 비밀번호가 일치합니다."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passErrorLabel.isHidden = true
        checkErrorLabel.isHidden = true
        emptyErrorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
