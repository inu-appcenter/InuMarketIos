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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendButtonClicked(_ sender: Any) {
        
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
