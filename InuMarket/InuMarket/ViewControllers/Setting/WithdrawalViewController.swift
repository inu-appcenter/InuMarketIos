//
//  WithdrawalViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 6..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class WithdrawalViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var withdrawalButton: UIButton!
    
    var model : NetworkModel?
    var deleteResult : AnsResult?
    
    
    @IBAction func withdrawalButtonClicked(_ sender: Any) {
        if idTextField.text != "" && passwdTextField.text != ""{

            model?.deleteUser(id: "\(idTextField.text!)", passwd: "\(passwdTextField.text!)")
            
            if deleteResult?.ans == true{
            let alertController = UIAlertController(title: "탈퇴완료!", message: "다음에 다시봐요.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
                }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        model = NetworkModel(self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializing() {
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        withdrawalButton.addSubview(customSubview)
    }
    
}

extension WithdrawalViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "deleteUserSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
                self.deleteResult = obj
            }
        }
    }
    
    func networkFail(code: String) {
        if code == "deleteUserError"{
            print("error")
        }
    }
}
