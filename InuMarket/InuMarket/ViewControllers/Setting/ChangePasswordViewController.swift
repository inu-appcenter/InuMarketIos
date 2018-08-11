//
//  ChangePasswordViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 6..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var countErrorLabel: UILabel!
    @IBOutlet weak var correctErrorLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordCheckTextField: UITextField!
    
    var model : NetworkModel?
    var changePasswdResult : AnsResult?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        model = NetworkModel(self)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        
        if oldPasswordTextField.text != "" && newPasswordTextField.text == newPasswordCheckTextField.text{
            model?.changePasswd(id: (self.appDelegate.userInfo?.id)!, pastPasswd: oldPasswordTextField.text!, newPasswd: newPasswordTextField.text!)
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
            if self.changePasswdResult?.ans == true{
                let alertController = UIAlertController(title: "비밀번호 변경 완료.", message: "다시 로그인 해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                
                let alertController = UIAlertController(title: "변경 실패", message: "비밀번호를 다시 확인해 주세요.", preferredStyle: UIAlertControllerStyle.alert)
                let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
                alertController.addAction(cancelButton)
                self.present(alertController, animated: true, completion: nil)
                
            }
            }
        
        }
        
    }
    
    func initializing() {
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        sendButton.addSubview(customSubview)
    }
    
}

extension ChangePasswordViewController:NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "changePasswdSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
                self.changePasswdResult = obj
            }
        }
    }
    func networkFail(code: String) {
        if code == "changePasswdError "{
            print("실패했어용")
        }
    }
}
