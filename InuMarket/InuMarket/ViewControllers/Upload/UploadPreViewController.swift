//
//  UploadPreViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 12..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow

class UploadPreViewController: UIViewController {

    @IBOutlet weak var uploadTable: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    var userfile: [UIImage]? = []
    var category: String?
    var productName: String?
    var productState: String?
    var productPrice: String?
    var productInfo: String?
    var method: String?
    var place: String?
    var localSource: [ImageSource]? = []

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var model : NetworkModel?
    var uploadResult : AnsResult?
    
    var id2String : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        model = NetworkModel(self)

    }

    @IBAction func sendButtonClicked(_ sender: Any) {
        id2String = self.appDelegate.userInfo?.id!
        model?.uploadProduct(userfile: userfile!, category: category!, productName: productName!, productState: productState!, productPrice: productPrice!, productInfo: productInfo!, method: method!, place: place!, id: id2String!)
        let time = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: time) {
            //2초 지나고 나타날 행동
            if self.uploadResult?.ans == true{
                self.appDelegate.userInfo?.product = (self.appDelegate.userInfo?.product)! + 1
                let alertController = UIAlertController(title: "등록이 완료되었습니다.", message: "내상품 확인해 주세요.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                    self.navigationController?.popToRootViewController(animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                
                let alertController = UIAlertController(title: "등록 실패", message: "실패라면 실패야", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
//                    self.navigationController?.popToRootViewController(animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }
    

    func initializing() {
   
        
        for i in 0..<userfile!.count{
            localSource?.append(ImageSource(image: userfile![i]))
        }
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        sendButton.addSubview(customSubview)
    }
    
}
extension UploadPreViewController: UITableViewDelegate, UITableViewDataSource{
//    섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
//    섹션 별 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
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
        explainCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        imageCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        infoCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)

        switch indexPath.section {
        case 0:
            imageCell.slideshow.slideshowInterval = 3.0
            imageCell.slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
            
            imageCell.slideshow.setImageInputs(self.localSource!)

            return imageCell
        case 1:
            infoCell.nameLabel.text = productName
            infoCell.priceLabel.text = "\(productPrice!)원"
            return infoCell
        case 2:
            explainCell.explainLabel.text = productInfo
            explainCell.categoryLabel.text = "- 카테 고리 : \(category!)"
            explainCell.methodLabel.text = "- 거래 방식 : \(method!)"
            explainCell.stateLabel.text = "- 상품 상태 : \(productState!)"
            explainCell.explainLabel.isEditable = false
            if method == "postbox"{
                explainCell.placeLabel.text = "- 거래 장소 : 택배거래"
            }else{
                explainCell.placeLabel.text = "- 거래 장소 : \(place!)"
            }
            return explainCell
        default:
            return infoCell
        }
    }
    //셀이 눌릴때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}


extension UploadPreViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "uploadProductSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
                self.uploadResult = obj
        }
    }
    }

    func networkFail(code: String) {
        if code == "uploadProductError"{
            print("실패했습니다.")
        }
    }


}
