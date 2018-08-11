//
//  ForgotPasswordViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 25..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailButton: UIButton!
    
    var model : NetworkModel?
    var forgotPasswordResult : AnsResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        model = NetworkModel(self)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emailButtonClicked(_ sender: Any) {
        
//        model?.login(id: "\(idTextField.text!)", passwd: "\(passTextField.text!)")

        if (idTextField.text?.count)! == 9 && nameTextFiled.text != ""{
            errorLabel.isHidden = true
            model?.forgotPass(id: "\(idTextField.text!)", name: "\(nameTextFiled.text!)")
            
            self.view.makeToast("비밀번호 처리중")
            let time = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: time) {
                //2초 지나고 나타날 행동
                if self.forgotPasswordResult?.ans == true{
                    let alertController = UIAlertController(title: "임시 비밀번호가 발급되었습니다.", message: "이메일을 통해 확인후 로그인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    
                    let alertController = UIAlertController(title: "비밀번호찾기 실패", message: "학번과 이름이 안맞아요.", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                        self.idTextField.text = ""
                        self.nameTextFiled.text = ""
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        } else{
            errorLabel.isHidden = false
        }
    }
    
    
    func initializing() {
//         button initializing
        emailButton.layer.cornerRadius = 10.0
        emailButton.layer.borderWidth = 1.0
        emailButton.layer.borderColor = UIColor.white.cgColor
        emailButton.layer.backgroundColor = UIColor.white.cgColor
        emailButton.layer.masksToBounds = true
        emailButton.layer.shadowColor = UIColor.lightGray.cgColor
        emailButton.layer.shadowOffset = CGSize.zero
        emailButton.layer.shadowRadius = 2.5
        emailButton.layer.shadowOpacity = 0.8
        emailButton.layer.masksToBounds = false
        
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

extension ForgotPasswordViewController: NetworkCallback {
    func networkSuc(resultdata: Any, code: String) {
        if code == "newPasswordSuccess" {
            
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
                self.forgotPasswordResult = obj
            }
        }
    }
    
    func networkFail(code: String) {
        if(code == "newPasswordSuccessError") {
            print("실패하였습니다.")
        }
    }
    
    
}
