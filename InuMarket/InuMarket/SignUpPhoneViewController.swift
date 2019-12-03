//
//  SignUpPhoneViewController.swift
//  InuMarket
//
//  Created by 김성은 on 26/10/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class SignUpPhoneViewController: UIViewController {

    var name: String = ""
    var id: String = ""
    var major: String = ""
    var pass: String = ""
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        if phoneTextField.text != "" {
            errorLabel.isHidden = true
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpReviewViewController") as? SignUpReviewViewController{
                vc.name = name
                vc.id = id
                vc.pass = pass
                vc.major = major
                vc.phone = phoneTextField.text!
                self.navigationController?.show(vc, sender: nil)
            }
        }else {
            errorLabel.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.isHidden = true
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
