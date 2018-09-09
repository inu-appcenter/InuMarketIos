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

class LetterBoxViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    //MARK: properties
    var index: IndexPath = []
    var number: String = ""
    var name: String = ""
    var category: String = ""
    // 판매중 판매중 상품
    var sellSellLetter:[LetterList] = []{
        didSet {
            if self.sellView != nil {
                self.sellView.reloadData()
            }
        }
    }
    // 판매중 판매완료 상품
    var sellEndLetter:[LetterList] = []{
        didSet {
            if self.sellView != nil {
                self.sellView.reloadData()
            }
        }
    }
    // 구매중 판매중 상품
    var buySellLetter:[LetterList] = []{
        didSet {
            if self.buyView != nil {
                self.buyView.reloadData()
            }
        }
    }
    // 구매중 판매완료 상품
    var buyEndLetter:[LetterList] = []{
        didSet {
            if self.buyView != nil {
                self.buyView.reloadData()
            }
        }
    }
    
    var model : NetworkModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    //MARK: IBOutlet
    @IBOutlet weak var letterSegmentedControl: BetterSegmentedControl!
    @IBOutlet weak var sellView: ExpandableTableView!
    @IBOutlet weak var buyView: ExpandableTableView!
    
    
    //MARK: IBAction
    @IBAction func changedSegmentedControl(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            sellView.isHidden = false
            buyView.isHidden = true
        case 1:
            sellView.isHidden = true
            buyView.isHidden = false
        default: break
        }
    }

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sellView.isHidden = false
        buyView.isHidden = true

        model = NetworkModel(self)
        model?.letterList(id: (self.appDelegate.userInfo?.id)!)
        
        // Do any additional setup after loading the view.
        navigationItem.title = "쪽지함"
        
        letterSegmentedControl.titles = ["판매중인 상품", "구매중인 상품"]
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 4.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        letterSegmentedControl.addSubviewToIndicator(customSubview)
        
        letterSegmentedControl.layer.shadowColor = UIColor.black.cgColor
        letterSegmentedControl.layer.shadowOpacity = 0.25
        letterSegmentedControl.layer.masksToBounds = false
        letterSegmentedControl.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        sellView.expandableDelegate = self
        sellView.animation = .automatic
        sellView.register(UINib(nibName: LetterListTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterListTableViewCell.ID)
        sellView.register(UINib(nibName: LetterContentTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterContentTableViewCell.ID)
        sellView.tableFooterView = UIView()
        sellView.closeAll()
        sellView.reloadData()
        
        buyView.expandableDelegate = self
        buyView.animation = .automatic
        buyView.register(UINib(nibName: LetterListTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterListTableViewCell.ID)
        buyView.register(UINib(nibName: LetterContentTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterContentTableViewCell.ID)
        buyView.tableFooterView = UIView()
        buyView.closeAll()
        buyView.reloadData()
    }
    
    //MARK: Methods
    @objc private func contactTapped(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let call = UIAlertAction(title: "전화걸기", style: .default) {
            (_) in
            guard let number = URL(string: "tel://" + self.number) else { return }
            UIApplication.shared.open(number)
            return
        }
        let message = UIAlertAction(title: "메세지 보내기", style: .default) {
            (_) in
            if MFMessageComposeViewController.canSendText() {
                let recipients: [String] = [self.number]
                let messageController = MFMessageComposeViewController()
                messageController.messageComposeDelegate = self
                messageController.recipients = recipients
                self.present(messageController, animated: true, completion: nil)
            }
            return
        }
        let copy = UIAlertAction(title: "번호 복사", style: .default) {
            (_) in
            UIPasteboard.general.string = self.number
            return
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) {
            (_) in
            return
        }
        alert.addAction(call)
        alert.addAction(message)
        alert.addAction(copy)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    @objc private func cancelTapped() {
        sellView.close(at: index)
        buyView.close(at: index)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LetterBoxViewController: ExpandableDelegate {
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [152]
    }
    
    func numberOfSections(in expandableTableView: ExpandableTableView) -> Int {
        return 2
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let sellCell = sellView.dequeueReusableCell(withIdentifier: LetterContentTableViewCell.ID) as! LetterContentTableViewCell
        let buyCell = buyView.dequeueReusableCell(withIdentifier: LetterContentTableViewCell.ID) as! LetterContentTableViewCell
        
        switch indexPath.section {
        case 0:
            if letterSegmentedControl.index == 0{
//                sellSellLetter
                name = self.sellSellLetter[indexPath.row].senderName!
                number = self.sellSellLetter[indexPath.row].senderPhone!
                sellCell.nameLabel.text = "구매자 이름 : \(name)"
                sellCell.phoneNumLabel.text = "전화번호 : \(number)"
                index = indexPath
                sellCell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
                sellCell.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
                sellCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return [sellCell]
            }else {
//                buySellLetter
                name = self.buySellLetter[indexPath.row].senderName!
                number = self.buySellLetter[indexPath.row].senderPhone!
                buyCell.nameLabel.text = "판매자 이름 : \(name)"
                buyCell.phoneNumLabel.text = "전화번호 : \(number)"
                index = indexPath
                buyCell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
                buyCell.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
                buyCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return [buyCell]
            }
        case 1:
            if letterSegmentedControl.index == 0{
//                sellEndLetter
                name = self.sellEndLetter[indexPath.row].senderName!
                number = self.sellEndLetter[indexPath.row].senderPhone!
                sellCell.nameLabel.text = "구매자 이름 : \(name)"
                sellCell.phoneNumLabel.text = "전화번호 : \(number)"
                index = indexPath
                sellCell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
                sellCell.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
                sellCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return [sellCell]
            }else {
//                buyEndLetter
                name = self.buyEndLetter[indexPath.row].senderName!
                number = self.buyEndLetter[indexPath.row].senderPhone!
                buyCell.nameLabel.text = "판매자 이름 : \(name)"
                buyCell.phoneNumLabel.text = "전화번호 : \(number)"
                index = indexPath
                buyCell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
                buyCell.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
                buyCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return [buyCell]
            }
        default:
            return [buyCell]
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        
        if letterSegmentedControl.index == 0 {
            if section == 0{
                return sellSellLetter.count
            }else if section == 1{
                return sellEndLetter.count
            }else{
                return 0
            }
        } else if letterSegmentedControl.index == 1 {
            if section == 0{
            return buySellLetter.count
            }else if section == 1{
                return buyEndLetter.count
            }else{
                return 0
            }
        } else {
            return 0
        }
    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sellCell: LetterListTableViewCell = sellView.dequeueReusableCell(withIdentifier: LetterListTableViewCell.ID) as? LetterListTableViewCell else { return UITableViewCell() }
        guard let buyCell: LetterListTableViewCell = buyView.dequeueReusableCell(withIdentifier: LetterListTableViewCell.ID) as? LetterListTableViewCell else { return UITableViewCell() }
        
        if letterSegmentedControl.index == 0 {
            if indexPath.section == 0{
                sellCell.backgroundColor = UIColor.white
                sellCell.endTitle.isHidden = true
                sellCell.letterTitle.text = sellSellLetter[indexPath.row].productName
                category = sellSellLetter[indexPath.row].productCategory!
                switch category.first{
                case "책": sellCell.letterImg.image = UIImage(named: "book")
                    break
                case "의": sellCell.letterImg.image = UIImage(named: "cloth")
                    break
                case "가": sellCell.letterImg.image = UIImage(named: "electirc")
                    break
                case "잡": sellCell.letterImg.image = UIImage(named: "etc")
                    break
                case "원": sellCell.letterImg.image = UIImage(named: "room")
                    break
                case "식": sellCell.letterImg.image = UIImage(named: "food")
                    break
                default: sellCell.letterImg.image = UIImage(named: "X")
                    break
                }
                sellCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return sellCell
            }else {
                sellCell.backgroundColor = UIColor.lightGray
                sellCell.endTitle.isHidden = false
                sellCell.letterTitle.text = sellEndLetter[indexPath.row].productName
                category = sellEndLetter[indexPath.row].productCategory!
                switch category.first{
                case "책": sellCell.letterImg.image = UIImage(named: "book")
                    break
                case "의": sellCell.letterImg.image = UIImage(named: "cloth")
                    break
                case "가": sellCell.letterImg.image = UIImage(named: "electirc")
                    break
                case "잡": sellCell.letterImg.image = UIImage(named: "etc")
                    break
                case "원": sellCell.letterImg.image = UIImage(named: "room")
                    break
                case "식": sellCell.letterImg.image = UIImage(named: "food")
                    break
                default: sellCell.letterImg.image = UIImage(named: "X")
                    break
                }
                sellCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return sellCell
            }
        } else {
            if indexPath.section == 0{
                buyCell.backgroundColor = UIColor.white
                buyCell.endTitle.isHidden = true
                buyCell.letterTitle.text = buySellLetter[indexPath.row].productName
                category = buySellLetter[indexPath.row].productCategory!
                switch category.first{
                case "책": buyCell.letterImg.image = UIImage(named: "book")
                    break
                case "의": buyCell.letterImg.image = UIImage(named: "cloth")
                    break
                case "가": buyCell.letterImg.image = UIImage(named: "electirc")
                    break
                case "잡": buyCell.letterImg.image = UIImage(named: "etc")
                    break
                case "원": buyCell.letterImg.image = UIImage(named: "room")
                    break
                case "식": buyCell.letterImg.image = UIImage(named: "food")
                    break
                default: buyCell.letterImg.image = UIImage(named: "X")
                    break
                }
                buyCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return buyCell
            } else{
                buyCell.backgroundColor = UIColor.lightGray
                buyCell.endTitle.isHidden = false
                buyCell.letterTitle.text = buyEndLetter[indexPath.row].productName
                category = buyEndLetter[indexPath.row].productCategory!
                switch category.first{
                case "책": buyCell.letterImg.image = UIImage(named: "book")
                    break
                case "의": buyCell.letterImg.image = UIImage(named: "cloth")
                    break
                case "가": buyCell.letterImg.image = UIImage(named: "electirc")
                    break
                case "잡": buyCell.letterImg.image = UIImage(named: "etc")
                    break
                case "원": buyCell.letterImg.image = UIImage(named: "room")
                    break
                case "식": buyCell.letterImg.image = UIImage(named: "food")
                    break
                default: buyCell.letterImg.image = UIImage(named: "X")
                    break
                }
                buyCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                return buyCell
            }
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRow:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
        print("didSelectExpandedRowAt:\(indexPath)")
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        if let cell = expandedCell as? LetterContentTableViewCell {
            print("\(cell.nameLabel.text ?? "")")
        }
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

extension LetterBoxViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "letterListSuccess" {
            print(resultdata)
            
            var temp: [LetterList] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                let letterId = item["letterId"] as? String ?? ""
                let sendId = item["sendId"] as? String ?? ""
                let reciveId = item["reciveId"] as? String ?? ""
                let sellBuy = item["sellBuy"] as? Bool ?? false
                let letterRead = item["letterRead"] as? Bool ?? false
                let productId = item["productId"] as? String ?? ""
                let productName = item["productName"] as? String ?? ""
                let sendDate = item["sendDate"] as? String ?? ""
                let senderPhone = item["senderPhone"] as? String ?? ""
                let productSelled = item["productSelled"] as? Bool ?? false
                let senderName = item["senderName"] as? String ?? ""
                let productCategory = item["productCategory"] as? String ?? ""
                    let obj = LetterList.init(letterId: letterId, sendId: sendId, reciveId: reciveId, sellBuy: sellBuy, letterRead: letterRead, productId: productId, productName: productName, sendDate: sendDate, senderPhone: senderPhone,productSelled: productSelled,senderName: senderName, productCategory: productCategory)
                temp.append(obj)
                

                }
            }
//            code
            for i in 0..<temp.count{
                if temp[i].sellBuy == true {
                    if temp[i].productSelled == false{
                        // 판매판매중
                        sellSellLetter.append(temp[i])
                    }else{
                        // 판매판매완료
                        sellEndLetter.append(temp[i])
                    }
                }else {
                    if temp[i].productSelled == false{
                        // 구매판매중
                        buySellLetter.append(temp[i])
                    }else{
                        // 구매판매완료
                        buyEndLetter.append(temp[i])
                    }
                }
            }

        }
    }
    
    func networkFail(code: String) {
        if code == "letterListError"{
            print("error")
        }
    }
    
    
}
