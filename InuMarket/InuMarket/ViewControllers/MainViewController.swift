//
//  MainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    
    
    @IBAction func button(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "MyProductTable") as? MyProductTableViewController {
            
            self.navigationController?.show(vc, sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func leftButtonDidPressed(_ sender: Any) {

        

    }
    
    @IBAction func rightButtonDidPressed(_ sender: Any) {

        
    }
    

    func initializing() {
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

extension MainViewController: ViewCallback{
    
    func viewSuc(code: String) {
        if code == "letter"{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "MyProductTable") as? MyProductTableViewController {
                print("123")
                self.navigationController?.show(vc, sender: nil)
                print("1")
                
            }
        }
    }
    
    func viewFail(code: String) {
        print("오류가 생겼어욤")
    }
    
    
}
