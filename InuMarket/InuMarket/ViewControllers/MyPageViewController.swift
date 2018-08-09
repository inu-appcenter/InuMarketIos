//
//  MyPageViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit


class MyPageViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var profileInfo:UserInfo?
    var letter2Int : Int?
    var product2Int : Int?
    
    @IBOutlet weak var productCountLabel: UILabel!
    
    @IBOutlet weak var letterCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBAction func myProductButtonClicked(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "MyProductTable") as? MyProductTableViewController {
        
            self.navigationController?.show(vc, sender: nil)
            
        }
        

    }
    @IBAction func productMakeButtonClicked(_ sender: Any) {
        let uploadStoryBoard :UIStoryboard = UIStoryboard(name: "Upload", bundle: nil)
        
        if let vc = uploadStoryBoard.instantiateViewController(withIdentifier: "UploadCategory") as? UploadCategoryViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    @IBAction func letterButtonClicked(_ sender: Any) {
    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        let settingStotyBoard :UIStoryboard = UIStoryboard(name: "Setting", bundle: nil)
        
        if let vc = settingStotyBoard.instantiateViewController(withIdentifier: "SettingView") as? SettingViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileInfo = self.appDelegate.userInfo

        letter2Int = profileInfo?.letter
        product2Int = profileInfo?.product
        
        userNameLabel.text = self.appDelegate.userInfo?.name
        productCountLabel.text = "\(product2Int!)"
        letterCountLabel.text = "\(letter2Int!)"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
