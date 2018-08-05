//
//  SetPhoneViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 31..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class SetPhoneViewController: UIViewController {
    
    var name : String = ""
    var id : String = ""
    var passwd : String = ""
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if phoneTextField.text?.count == 11{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Review") as? ReviewViewController{
                vc.tel = phoneTextField.text!
                vc.passwd = passwd
                vc.id = id
                vc.name = name
                self.navigationController?.show(vc, sender: nil)
            }
        }else{
            print("h")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
