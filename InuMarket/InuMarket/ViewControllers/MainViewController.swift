//
//  MainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import SideMenu

class MainViewController: UIViewController {

    
    let categoryStoryBoard: UIStoryboard = UIStoryboard(name: "Category", bundle: nil)
    let myPageStoryBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupSideMenu(){

        SideMenuManager.default.menuLeftNavigationController = categoryStoryBoard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuRightNavigationController = myPageStoryBoard.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController

        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
