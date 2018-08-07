//
//  QustViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 6..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class QustViewController: UIViewController {
    
    @IBOutlet weak var qustTextView: UITextView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func sendButtonClicked(_ sender: Any) {
        if qustTextView.text == "" {
            errorLabel.isHidden = false
        }else{
            errorLabel.isHidden = true
            
            let alertController = UIAlertController(title: "전송! 전전송송! 문희문희나문희.", message: "확인을 누르면 전송됩니다.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            
            let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(cancelButton)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initializing() {
        // textView 테두리 색 넣어주기
        qustTextView.layer.borderWidth = 2.0
        qustTextView.layer.borderColor = UIColor(red: 238/255, green: 240/255, blue: 242/255, alpha: 1.0).cgColor
        qustTextView.layer.cornerRadius = 5.0
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        sendButton.addSubview(customSubview)
    }
}