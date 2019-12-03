//
//  ForgotPasswordViewController.swift
//  InuMarket
//
//  Created by 김성은 on 17/09/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 이메일 버튼
        emailButton.layer.cornerRadius = 8.0
        emailButton.layer.borderWidth = 1.0
        emailButton.layer.borderColor = UIColor.white.cgColor
        emailButton.layer.backgroundColor = UIColor.white.cgColor
        emailButton.layer.masksToBounds = true
        emailButton.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.18).cgColor
        emailButton.layer.shadowOffset = CGSize.zero
        emailButton.layer.shadowRadius = 9.0
        emailButton.layer.shadowOpacity = 0.8
        emailButton.layer.masksToBounds = false

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
