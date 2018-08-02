//
//  ViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 1..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift
import KWDrawerController

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginResult : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
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
        
//        loginInfo = "id=\(idTextField.text!)&passwd=\(passTextField.text!)"
//        print(loginInfo)
//        let model = NetworkModel(self)
//        model.login(param: loginInfo)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "MainNavi") as? UINavigationController {
            self.present(vc, animated: true, completion: nil)
        }
        
    }

    @IBAction func signupButtonClicked(_ sender: Any) {
    }
    
    @IBAction func lossPassButtonClicked(_ sender: Any) {

        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "forgotPassword") as? ForgotPasswordViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
    func initializing() {
        // button initializing
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.backgroundColor = UIColor.white.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
        loginButton.layer.shadowOffset = CGSize.zero
        loginButton.layer.shadowRadius = 2.5
        loginButton.layer.shadowOpacity = 0.8
        loginButton.layer.masksToBounds = false

        
        // navigation initializing
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        let mainlogo = UIImage(named: "mainLogo.png")
        let imageview = UIImageView(image: mainlogo)
        self.navigationItem.titleView = imageview
        
    }

}

extension LoginViewController : NetworkCallback{

    func networkSuc(resultdata: Any, code: String) {
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
                errorLabel.isHidden = false
                self.view.makeToast("아이디와 비밀번호가 틀렸습니다.")
            }
    
            
        }
    }
    func networkFail(code: String) {
        if(code == "loginError") {
            print("실패하였습니다.")
        }
    }
    
    
}
