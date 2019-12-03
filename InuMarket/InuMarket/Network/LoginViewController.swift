//
//  LoginViewController.swift
//  InuMarket
//
//  Created by 김성은 on 03/04/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var wrongPassLabel: UILabel!
    
    @IBAction func autoLoginButtonClicked(_ sender: Any) {
        if autoLoginButton.isSelected == true{
            autoLoginButton.isSelected = false
        } else{
            autoLoginButton.isSelected = true
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpAgreementViewController") as? SignUpAgreementViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    @IBAction func forgotPassButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 자동로그인
        autoLoginButton.setImage(UIImage.init(named: "uncheck"), for: .normal)
        autoLoginButton.setImage(UIImage.init(named: "checked"), for: .selected)
        
        // 로그인 버튼
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.backgroundColor = UIColor.white.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.18).cgColor
        loginButton.layer.shadowOffset = CGSize.zero
        loginButton.layer.shadowRadius = 9.0
        loginButton.layer.shadowOpacity = 0.8
        loginButton.layer.masksToBounds = false
       
        // 네비게이션 바
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
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
