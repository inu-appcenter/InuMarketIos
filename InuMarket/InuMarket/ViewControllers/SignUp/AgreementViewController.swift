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
        initializing()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func checkboxButtonClicked(_ sender: Any) {
        if checkboxButton.isSelected == true{
            checkboxButton.isSelected = false
        }else{
            checkboxButton.isSelected = true
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if checkboxButton.isSelected == true{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "StudentInfo") as? StudentInfoViewController{
                self.navigationController?.show(vc, sender: nil)
            }
        }else{
            errorLabel.isHidden = false
        }
    }
    
    
    
    func initializing() {
        
        
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        nextButton.addSubview(customSubview)
    }
}

