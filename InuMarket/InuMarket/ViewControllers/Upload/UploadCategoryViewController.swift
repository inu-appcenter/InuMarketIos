//
//  UploadCategoryViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 9..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class UploadCategoryViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    

    
    @IBOutlet weak var UploadCategoryTable: UITableView!
    
    let category = ["책","의류","가전 / 가구", "생활 / 사무", "잡화","원룸","식권"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "상품 등록하기"
        UploadCategoryTable.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    //섹션별 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    // 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 셀별 상세정보
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UploadCategoryTableViewCell") as! UploadCategoryTableViewCell
        
        cell.categoryLabel.text = category[indexPath.row]
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        return cell
    }
    
    // 셀 눌렀을때 눌린 상태 수정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        
        cell?.selectedBackgroundView?.backgroundColor = UIColor(red: 69/255.0, green: 222/255.0, blue: 157/255.0, alpha: 1.0)
        
        cell?.isSelected = true
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadInfo") as? UploadInfoViewController{
            self.navigationController?.show(vc, sender: nil)
        }
        
    }

}
