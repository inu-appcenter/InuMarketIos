
import UIKit
import ExpandableCell
import MessageUI

class buyLetterViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    //MARK: properties
    var index: IndexPath = []
    var number: String = ""
    var name: String = ""
    var category: String = ""
    
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
    @IBOutlet weak var buyView: ExpandableTableView!
    
    //MARK: IBAction
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = NetworkModel(self)
        model?.letterList(id: (self.appDelegate.userInfo?.id)!)
        
        buyView.expandableDelegate = self
        buyView.animation = .automatic
        buyView.register(UINib(nibName: LetterListTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterListTableViewCell.ID)
        buyView.register(UINib(nibName: LetterContentTableViewCell.ID, bundle: nil), forCellReuseIdentifier: LetterContentTableViewCell.ID)
        buyView.tableFooterView = UIView()
        buyView.closeAll()
        buyView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        buyView.closeAll()
    }
    
    //MARK: Methods
    func reloadAndClose() {
        if self.buyView != nil {
            buyView.closeAll()
            buyView.reloadData()
        }
    }
    
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
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension buyLetterViewController: ExpandableDelegate {
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [152]
    }
    
    func numberOfSections(in expandableTableView: ExpandableTableView) -> Int {
        return 2
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let buyCell = buyView.dequeueReusableCell(withIdentifier: LetterContentTableViewCell.ID) as! LetterContentTableViewCell
        
        switch indexPath.section {
        case 0:
            
            //                sellSellLetter
            name = self.buySellLetter[indexPath.row].senderName!
            number = self.buySellLetter[indexPath.row].senderPhone!
            buyCell.nameLabel.text = "구매자 이름 : \(name)"
            buyCell.phoneNumLabel.text = "전화번호 : \(number)"
            index = indexPath
            buyCell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
            buyCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            return [buyCell]
        case 1:
            //                sellEndLetter
            name = self.buyEndLetter[indexPath.row].senderName!
            number = self.buyEndLetter[indexPath.row].senderPhone!
            buyCell.nameLabel.text = "구매자 이름 : \(name)"
            buyCell.phoneNumLabel.text = "전화번호 : \(number)"
            index = indexPath
            buyCell.contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
            buyCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            return [buyCell]
        default:
            return [buyCell]
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return buySellLetter.count
        }else if section == 1{
            return buyEndLetter.count
        }else{
            return 0
        }
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let buyCell: LetterListTableViewCell = buyView.dequeueReusableCell(withIdentifier: LetterListTableViewCell.ID) as? LetterListTableViewCell else { return UITableViewCell() }
        
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
        }else {
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

extension buyLetterViewController: NetworkCallback{
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
//                        sellSellLetter.append(temp[i])
                    }else{
                        // 판매판매완료
//                        sellEndLetter.append(temp[i])
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

