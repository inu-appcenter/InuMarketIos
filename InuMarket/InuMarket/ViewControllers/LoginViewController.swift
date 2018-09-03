//
//  ViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 1..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var autoLoginButton: UIButton!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        
        initializing()
        idTextField.delegate = self
        passTextField.delegate = self
        
        if UserDefaults.standard.string(forKey: "id") != nil{
        self.idTextField.text = UserDefaults.standard.string(forKey: "id")
        self.passTextField.text = UserDefaults.standard.string(forKey: "pass")
            autoLoginButton.isSelected = true
        self.appDelegate.deviceToken = UserDefaults.standard.string(forKey: "FCM")
            loginButtonClicked((Any).self)
        }
        
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
    
    @IBAction func autoLoginButtonClicked(_ sender: Any) {
        if autoLoginButton.isSelected == true{
            autoLoginButton.isSelected = false
            
        }else{
            autoLoginButton.isSelected = true
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        
        model?.login(id: "\(idTextField.text!)", passwd: "\(passTextField.text!)", FCM: "\(self.appDelegate.deviceToken!)")
        
        self.view.makeToast("로그인중")
        startLoading()
        
        
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Agreement") as? AgreementViewController{
            self.navigationController?.show(vc, sender: nil)
        }
        
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
        
        
        idTextField.text = nil
        passTextField.text = nil
        
        autoLoginButton.setImage(#imageLiteral(resourceName: "check"), for: .selected)
        autoLoginButton.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        
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
            self.appDelegate.userInfo = nil
            print(resultdata)
            
            var temp: [UserInfo] = []
            
            if let item = resultdata as? NSDictionary {
                let token = item["token"] as? String ?? ""
                let id = item["id"] as? String ?? ""
                let name = item["name"] as? String ?? ""
                let tel = item["tel"] as? String ?? ""
                let message = item["message"] as? String ?? ""
                let letter = item["letter"] as? Int ?? 0
                let product = item["product"] as? Int ?? 0
                let obj = UserInfo.init(token: token, id: id, name: name, tel: tel, message: message, letter: letter, product: product)
                temp.append(obj)
                
                self.appDelegate.userInfo = obj
            }
            endLoading()
        }
        
    }
    func networkFail(code: String) {
        if(code == "loginError") {
            print("실패하였습니다.")
        }
    }
    func startLoading(){
        self.view.makeToast("로그인중")
        self.loginButton.isEnabled = false
        self.view.makeToastActivity(.center)
    }
    func endLoading(){
        self.loginButton.isEnabled = true
        self.view.hideToastActivity()
        self.view.hideAllToasts()
        //2초 지나고 나타날 행동
        if self.appDelegate.userInfo?.message == "false"{
            self.view.makeToast("아이디와 비밀번호가 틀립니다.")
            self.idTextField.text = ""
            self.passTextField.text = ""
        }else if self.appDelegate.userInfo?.message == "certification"{
            self.view.makeToast("이메일 인증을 해야 사용가능합니다.")
            
        }else if self.appDelegate.userInfo?.message == "logged in success"{
            if self.autoLoginButton.isSelected{
                UserDefaults.standard.set(self.idTextField.text, forKey: "id")
                UserDefaults.standard.set(self.passTextField.text, forKey:"pass")
                UserDefaults.standard.set(self.appDelegate.deviceToken, forKey: "FCM")
                UserDefaults.standard.synchronize()
            }
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "MainNavi") as? UINavigationController {
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            self.view.makeToast("서버통신시간초과")
        }
    }
    
}
