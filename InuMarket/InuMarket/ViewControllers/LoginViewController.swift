//
//  ViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 1..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginResult : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        passTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // 배경 탭하면 키보드 사라지기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // return 버튼 누르면 다음칸으로 가고 마지막엔 꺼지기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField{
            passTextField.becomeFirstResponder()
        } else if textField == passTextField{
            textField.resignFirstResponder()
        }
        return true
    }

    
    @IBAction func loginButtonClicked(_ sender: Any) {
        var loginInfo : String
        
        loginInfo = "id=\(idTextField.text!)&passwd=\(passTextField.text!)"
        print(loginInfo)
        let model = NetworkModel(self)
        model.login(param: loginInfo)
        
        
    }

    @IBAction func signupButtonClicked(_ sender: Any) {
    }
    
    @IBAction func lossPassButtonClicked(_ sender: Any) {
    }
}

extension LoginViewController : NetworkCallback{

    func networkSuc(resultdata: Any, code: String, tag: Int) {
        if code == "loginSuccess" {
            print(resultdata)
            
            loginResult = resultdata as? Bool
            if loginResult == true {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController {
                    self.present(vc, animated: true, completion: nil)
                }
            } else{
                idTextField.text = ""
                passTextField.text = ""
            }
    
            
        }
    }
    func networkFail(code: String) {
        if(code == "loginError") {
            print("실패하였습니다.")
        }
    }
    
    
}
