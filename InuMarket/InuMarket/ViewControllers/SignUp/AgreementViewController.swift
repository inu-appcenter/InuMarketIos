//
//  AgreementViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 27..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "StudentInfo") as? StudentInfoViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
}

