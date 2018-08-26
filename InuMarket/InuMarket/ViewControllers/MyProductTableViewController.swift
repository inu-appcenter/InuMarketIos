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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var changePasswordResult : AnsResult?
    var category: String = ""
    
    var selledItem:[MyProductselled] = [] {
        didSet {
            if self.myProductTable != nil {
                self.myProductTable.reloadData()
            }
        }
    }
    var nonSelledItem:[MyProductNonsell] = [] {
        didSet {
            if self.myProductTable != nil {
                self.myProductTable.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myProductTable.delegate = self
        self.myProductTable.dataSource = self
        
        segmentCon()
        
        model = NetworkModel(self)
        print((self.appDelegate.userInfo?.id)!)
        model?.myProductSelled(sellerId: (self.appDelegate.userInfo?.id)!)
        model?.myProductNonSell(sellerId: (self.appDelegate.userInfo?.id)!)
        
        myProductTable.reloadData()
        
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
        
        segmentControl.layer.shadowColor = UIColor.black.cgColor
        segmentControl.layer.shadowOpacity = 0.25
        segmentControl.layer.masksToBounds = false
        segmentControl.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    //    세그먼트 값 변경시
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
        switch segmentControl.index {
        case 0:
            return nonSelledItem.count
        case 1:
            return selledItem.count
        default:
            return nonSelledItem.count
        }
        
        
    }
    // 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 셀별 상세정보
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProductTableViewCell") as! MyProductTableViewCell
        if segmentControl.index == 0{
            category = nonSelledItem[indexPath.row].category!
            switch category.first{
            case "책": cell.productImageView.image = UIImage(named: "book")
                break
            case "의": cell.productImageView.image = UIImage(named: "cloth")
                break
            case "가": cell.productImageView.image = UIImage(named: "electirc")
                break
            case "잡": cell.productImageView.image = UIImage(named: "etc")
                break
            case "원": cell.productImageView.image = UIImage(named: "room")
                break
            case "식": cell.productImageView.image = UIImage(named: "food")
                break
            default: cell.productImageView.image = UIImage(named: "X")
                break
            }
            cell.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
            cell.successLabel.isHidden = true
            cell.productNameLabel.text = nonSelledItem[indexPath.row].productName
            
        }else{  // segmentControl  index == 1  "판매 완료"
            cell.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)
            cell.successLabel.isHidden = false
            cell.successLabel.textColor = UIColor.white
            cell.productNameLabel.text = selledItem[indexPath.row].productName
            category = selledItem[indexPath.row].category!
            switch category.first{
            case "책": cell.productImageView.image = UIImage(named: "book")
                break
            case "의": cell.productImageView.image = UIImage(named: "cloth")
                break
            case "가": cell.productImageView.image = UIImage(named: "electric")
                break
            case "잡": cell.productImageView.image = UIImage(named: "etc")
                break
            case "원": cell.productImageView.image = UIImage(named: "room")
                break
            case "식": cell.productImageView.image = UIImage(named: "food")
                break
            default: cell.productImageView.image = UIImage(named: "X")
                break
            }
            
            
        }
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        return cell
    }
    // 섹션별 셀 수정가능 여부
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch segmentControl.index {
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
        
        // 상세 페이지 이동 코딩
        if segmentControl.index == 0 {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MyProductView") as? MyProductViewController{
                vc.productId = nonSelledItem[indexPath.row].productId
                self.navigationController?.show(vc, sender: nil)
            }
        }
        
    }
    // 수정할때 나올 문구 및 내용
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let complete = UITableViewRowAction(style: .destructive, title: "판매완료") { action, index in
            
            let alertController = UIAlertController(title: "판매완료 하시겠습니까?", message: "상품이 판매 완료 되면 고객이 상세정보를 열람할 수 없게 됩니다.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "판매완료", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                print("확인 누를때 수행될 내용")
                self.model?.changeProduct(productId: "\(self.nonSelledItem[indexPath.row].productId!)")
                
                
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

extension MyProductTableViewController:NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "myProductSell" {
            print(resultdata)
            
            var temp: [MyProductselled] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let productImg = item["productImg"] as? String ?? ""
                    let productId = item["productId"] as? String ?? ""
                    let productName = item["productName"] as? String ?? ""
                    let productPrise = item["productPrise"] as? String ?? ""
                    let productSelled = item["productSelled"] as? Bool ?? false
                    let sellerId = item["sellerId"] as? String ?? ""
                    let updateDate = item["updateDate"] as? String ?? ""
                    let category = item["category"] as? String ?? ""
                    let obj = MyProductselled.init(productImg: productImg, productId: productId, productName: productName, productPrise: productPrise, productSelled: productSelled, sellerId: sellerId, updateDate: updateDate, category: category)
                    temp.append(obj)
                }
            }
            selledItem = temp
            
        }else if code == "myProductNonSell"{
            print(resultdata)
            
            var temp: [MyProductNonsell] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let productImg = item["productImg"] as? String ?? ""
                    let productId = item["productId"] as? String ?? ""
                    let productName = item["productName"] as? String ?? ""
                    let productPrise = item["productPrise"] as? String ?? ""
                    let productSelled = item["productSelled"] as? Bool ?? false
                    let sellerId = item["sellerId"] as? String ?? ""
                    let updateDate = item["updateDate"] as? String ?? ""
                    let category = item["category"] as? String ?? ""
                    let obj = MyProductNonsell.init(productImg: productImg, productId: productId, productName: productName, productPrise: productPrise, productSelled: productSelled, sellerId: sellerId, updateDate: updateDate, category: category)
                    temp.append(obj)
                }
            }
            
            nonSelledItem = temp
            
        }else if code == "changeProductSuccess"{
            print(resultdata)
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
                self.changePasswordResult = obj
                
                model?.myProductSelled(sellerId: (self.appDelegate.userInfo?.id)!)
                model?.myProductNonSell(sellerId: (self.appDelegate.userInfo?.id)!)
            }
        }
    }
    
    func networkFail(code: String) {
        if(code == "cellError") {
            print("실패하였습니다.")
        }
        
    }
    
    
}
