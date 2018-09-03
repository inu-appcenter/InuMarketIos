//
//  MyProductViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 22..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Kingfisher
import ImageSlideshow

class MyProductViewController: UIViewController {

    
    var productId: String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var changePasswordResult : AnsResult?
    var detailList: detailProduct?{
        didSet {
            if self.myProductTable != nil {
                imageDownload()
                self.myProductTable.reloadData()
            }
        }
    }
    var imageCount: Int?
    var priceProduct : Int = 0
    var starProduct : Int = 0
    var stateProduct : String = ""
    var methodProduct : String = ""
    var placeProduct: String = ""
    var categoryProduct: String = ""
    var productImg: [KingfisherSource] = []

    
    @IBOutlet weak var myProductTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = NetworkModel(self)
        model?.detailProduct(productId: productId!)
        myProductTable.tableFooterView = UIView()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imageDownload(){
    for i in 0..<imageCount!{
    self.productImg.append(KingfisherSource(url:URL(string:"\(self.appDelegate.serverURL)imgload/\(detailList!.productImg![i])")!))
    }
    }
}

extension MyProductViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 240
        case 1:
            return 117
        case 2:
            return UITableViewAutomaticDimension
        default:
            return 0
        }
    }
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
            imageCell.slideshow.setImageInputs(self.productImg)
            
            return imageCell
        case 1:
            infoCell.nameLabel.text = detailList?.productName
            infoCell.priceLabel.text = "\(priceProduct)원"
            return infoCell
        case 2:
            explainCell.explainLabel.text = detailList?.productInfo
            explainCell.categoryLabel.text = "- 카테 고리 : \(categoryProduct)"
            explainCell.methodLabel.text = "- 거래 방식 : \(methodProduct)"
            explainCell.stateLabel.text = "- 상품 상태 : \(stateProduct)"
            explainCell.explainLabel.isEditable = false
            if methodProduct == "postbox"{
                explainCell.placeLabel.text = "- 거래 장소 : 택배거래"
            }else{
                explainCell.placeLabel.text = "- 거래 장소 : \(placeProduct)"
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

extension MyProductViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "detailSuccess"{
            print(resultdata)
            var temp: [detailProduct] = []
            if let items = resultdata as? NSDictionary {
                let productId = items["productId"] as? String ?? ""
                let productName = items["productName"] as? String ?? ""
                let category = items["category"] as? String ?? ""
                let updateDate = items["updateDate"] as? String ?? ""
                let productPrice = items["productPrice"] as? Int ?? 0
                let productSelled = items["productSelled"] as? Bool ?? false
                let productImg = items["productImg"] as? [String] ?? [""]
                let productState = items["productState"] as? String ?? ""
                let productStar = items["productStar"] as? Int ?? 0
                let productInfo = items["productInfo"] as? String ?? ""
                let method = items["method"] as? String ?? ""
                let place = items["place"] as? String ?? ""
                let sellerId = items["sellerId"] as? String ?? ""
                let sellerName = items["sellerName"] as? String ?? ""
                let sellerPhone = items["sellerPhone"] as? String ?? ""
                let obj = detailProduct.init(productImg: productImg, productId: productId, productName: productName, productState: productState, productStar: productStar, productPrice: productPrice, productSelled: productSelled, category: category, productInfo: productInfo, method: method, place: place, sellerId: sellerId, updateDate: updateDate, sellerName: sellerName, sellerPhone: sellerPhone)
                temp.append(obj)
                imageCount = obj.productImg?.count
                priceProduct = obj.productPrice!
                starProduct = obj.productStar!
                methodProduct = obj.method!
                placeProduct = obj.place!
                categoryProduct = obj.category!
                stateProduct = obj.productState!
                detailList = obj
                
            }
        }
    }
    func networkFail(code: String) {
        if code == "detailError"{
            print("error")
        }
    }
}
