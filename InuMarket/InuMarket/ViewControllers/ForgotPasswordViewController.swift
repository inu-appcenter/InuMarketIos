//
//  ForgotPasswordViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 25..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emailButtonClicked(_ sender: Any) {
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
