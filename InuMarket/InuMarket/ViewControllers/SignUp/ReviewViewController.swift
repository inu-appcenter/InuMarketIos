//
//  ReviewViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 31..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    
    var name : String = ""
    var id : String = ""
    var passwd : String = ""
    var tel : String = ""
    
    var model : NetworkModel?
    
    


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nextbutton: UIButton!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        model?.signUp(id : id, passwd: passwd, name: name, tel: tel)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        
        model = NetworkModel(self)

        nameLabel.text = name
        idLabel.text = id
        phoneLabel.text = tel
        
        // Do any additional setup after loading the view.
    }
    
    func initializing() {
        
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        nextbutton.addSubview(customSubview)
    }
}

extension ReviewViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "signSuccess"{
            print(resultdata)
            
            if resultdata as? Bool == true{
                let alertController = UIAlertController(title: "회원가입이 완료되었습니다.", message: "이메일 인증완료후 로그인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                print("Tlqkf")
            }
        }
        
    }

    func networkFail(code: String) {
        if(code == "signError") {
            print("실패하였습니다.")
        }
    }
    
    
}
