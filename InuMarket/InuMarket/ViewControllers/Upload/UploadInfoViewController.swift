//
//  UploadInfoViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 9..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Toast_Swift

class UploadInfoViewController: UIViewController {

    
    @IBOutlet weak var itemNameTextLabel: UITextField!
    @IBOutlet weak var itemProductTextLabel: UITextField!
    @IBOutlet weak var itemPriceTextLabel: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "상품 등록하기"
        self.navigationItem.leftBarButtonItem?.title = " "
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if itemNameTextLabel.text != "" && itemProductTextLabel.text != "" && itemPriceTextLabel.text != "" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadExplain") as? UploadExplainViewController{
                self.navigationController?.show(vc, sender: nil)
            }
            
        }
        else { self.view.makeToast("입력해주세요", duration: 2, position: .bottom) }
    }

}
