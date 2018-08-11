//
//  UploadPreViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 12..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class UploadPreViewController: UIViewController {

    @IBOutlet weak var uploadTable: UITableView!
    
    @IBAction func sendButtonClicked(_ sender: Any) {
    }
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension UploadPreViewController: UITableViewDelegate, UITableViewDataSource{
//    섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
//    섹션 별 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 240
        case 1:
            return 117
        case 2:
            return 230
        default:
            return 0
        }
    }
//    섹션별 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
//    셀이 상세정보
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "PreImage") as! PreImageViewTableViewCell
        let infoCell = tableView.dequeueReusableCell(withIdentifier: "PreInfo")as! PreInfoViewTableViewCell
        let explainCell = tableView.dequeueReusableCell(withIdentifier: "PreExplain")as! PreExplainViewTableViewCell
        switch indexPath.section {
        case 0:
            return imageCell
        case 1:
            return infoCell
        case 2:
            return explainCell
        default:
            return infoCell
        }
    }
    
}
