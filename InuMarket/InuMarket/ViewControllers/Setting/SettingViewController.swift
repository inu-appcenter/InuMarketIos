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
    
    @IBOutlet weak var settingTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 셀 개수 끝나면 뒤에 더이상 셀 나타나지 않기
        settingTable.tableFooterView = UIView()
        
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
        
        switch indexPath.row {

        case 0:  // 전화번호 변경
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PhoneChange") as? PhoneChangeViewController{
                self.navigationController?.show(vc, sender: nil)
            }
            break
            
        case 1:  // 푸시알림 설정
            print("123")
            break
        case 2:  // 문의하기
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Qust") as? QustViewController{
                self.navigationController?.show(vc, sender: nil)
            }
            break
        case 3:  //비밀번호 변경
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePassword") as? ChangePasswordViewController{
                self.navigationController?.show(vc, sender: nil)
            }
            break
        case 4:  // 로그아웃
            let alertController = UIAlertController(title: "로그아웃!", message: "확인을 누르면 로그아웃 됩니다.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            
            let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(cancelButton)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            break
        case 5:  // 회원 탈퇴
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Withdrawal") as? WithdrawalViewController{
                self.navigationController?.show(vc, sender: nil)
            }
            break
        default:
            print("버튼누르장")
        }
        
    }
}
