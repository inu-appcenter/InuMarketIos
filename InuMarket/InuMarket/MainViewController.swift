//
//  MainViewController.swift
//  InuMarket
//
//  Created by 김성은 on 04/12/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 47, height: 44))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
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
