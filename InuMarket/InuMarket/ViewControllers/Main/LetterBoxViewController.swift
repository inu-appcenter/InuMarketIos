//
//  LetterBoxViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import ExpandableCell
import MessageUI

class LetterBoxViewController: UIViewController {
    
    //MARK: properties
    

    //MARK: IBOutlet
    @IBOutlet weak var letterSegmentedControl: BetterSegmentedControl!
    @IBOutlet weak var sellView: UIView!
    @IBOutlet weak var buyView: UIView!
    
    var expanableView: ExpandableTableView = ExpandableTableView()
    
    //MARK: IBAction
    @IBAction func changedSegmentedControl(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            sellView.isHidden = false
            buyView.isHidden = true
            print("sellView")
        case 1:
            sellView.isHidden = true
            buyView.isHidden = false
            print("buyView")
        default: break
        }
    }

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "쪽지함"
        
        sellView.isHidden = false
        buyView.isHidden = true
        
        letterSegmentedControl.titles = ["판매중인 상품", "구매중인 상품"]
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 4.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        letterSegmentedControl.addSubviewToIndicator(customSubview)
        
        letterSegmentedControl.layer.shadowColor = UIColor.black.cgColor
        letterSegmentedControl.layer.shadowOpacity = 0.25
        letterSegmentedControl.layer.masksToBounds = false
        letterSegmentedControl.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buySeg" {
            if let nextViewController = segue.destination as? buyLetterViewController {
                nextViewController.reloadAndClose()
                print("buyView close")
            }
        } else if segue.identifier == "sellSeg" {
            if let nextViewController = segue.destination as? sellLetterViewController {
                nextViewController.reloadAndClose()
                print("sellView close")
            }
        }
    }
}

