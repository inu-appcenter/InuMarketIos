//
//  MyProductTableViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class MyProductTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var myProductTable: UITableView!
    @IBOutlet weak var segmentControl: BetterSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myProductTable.delegate = self
        self.myProductTable.dataSource = self

        segmentCon()
        
        // 테이블 아래 셀이 없으면 더이상 나오지 않게 하기
        myProductTable.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    func segmentCon() {
        segmentControl.titles = ["판매중", "판매 완료"]
        
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        segmentControl.addSubviewToIndicator(customSubview)
    }
    
//    세그먼트 값 시경시
    @IBAction func SegmentControlValueChanged(_ sender: BetterSegmentedControl) {
//        index 는 0부터 시작
        if sender.index == 0{
            
            self.myProductTable.reloadData()
            
        }else {
            self.myProductTable.reloadData()
            
        }
        
        
    }
    
    
   
    //섹션별 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    // 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 셀별 상세정보
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProductTableViewCell") as! MyProductTableViewCell
        cell.productNameLabel.text = "test"

        if segmentControl.index == 0{
            cell.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
            cell.successLabel.isHidden = true
            
            if indexPath.section == 0{
                cell.isHidden = false
            }else{
                cell.isHidden = true
            }
            
        }else{  // segmentControl  index == 1  "판매 완료"
            cell.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)
            cell.successLabel.isHidden = false
            cell.successLabel.textColor = UIColor.white
            
            if indexPath.section == 0{
                cell.isHidden = true
            }else{
                cell.isHidden = false
            }
            

        }
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)

        return cell
    }
    // 섹션별 셀 수정가능 여부
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return true
        case 1:
            return false
        default:
            return false
        }
    }
    
    // 셀 눌렀을때 눌린 상태 수정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    // 수정할때 나올 문구 및 내용
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
        let complete = UITableViewRowAction(style: .destructive, title: "판매완료") { action, index in
            
            let alertController = UIAlertController(title: "판매완료 하시겠습니까?", message: "상품이 판매 완료 되면 고객이 상세정보를 열람할 수 없게 됩니다.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "판매완료", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                print("확인 누를때 수행될 내용")
                
                self.myProductTable.reloadSections(IndexSet(0...0), with: .automatic)
                self.myProductTable.reloadData()
                
            }
            let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true, completion: nil)
        }
        complete.backgroundColor = UIColor(red: 251/255.0, green: 58/255.0, blue: 47/255.0, alpha: 1.0)
        
        return [complete]
    }
}

