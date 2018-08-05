//
//  SettingViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 5..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    let settingItems = ["전화번호 변경","푸시 알림 설정","문의하기","비밀번호 변경","로그아웃","회원 탈퇴"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Setting") as! SettingTableViewCell
        cell.titleLabel.text = settingItems[indexPath.row]
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.isSelected = false
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadInfo") as? UploadInfoViewController{
            self.navigationController?.show(vc, sender: nil)
        }
    }
}
