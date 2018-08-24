//
//  OtherProductViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 18..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Kingfisher

class OtherProductViewController: UIViewController {
    
    //MARK: properties
    var productName: String?
    let cellIdentifier: String = "MainCollectionViewCell"
    var sellerId: String?
    var model : NetworkModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var sellProductList: [AllProduct] = []{
        didSet {
            if self.otherProductCollectionView != nil {
                self.otherProductCollectionView.reloadData()
            }
        }
    }
    var nonsellProductList: [AllProduct] = []{
        didSet {
            if self.otherProductCollectionView != nil {
                self.otherProductCollectionView.reloadData()
            }
        }
    }
    //MARK: IBOutlet
    @IBOutlet weak var otherProductSegControl: BetterSegmentedControl!
    @IBOutlet weak var otherProductCollectionView: UICollectionView!
    
    //MARK: IBAction
    @IBAction func changedSegControl(_ sender: Any) {
        otherProductCollectionView.reloadData()
    }
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        model?.sellerIdSearchProduct(sellerId: sellerId!)

        otherProductCollectionView.reloadData()
        
        navigationItem.title = "판매자의 다른 상품"
        
        otherProductSegControl.titles = ["판매중", "판매 완료"]
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 4.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        otherProductSegControl.addSubviewToIndicator(customSubview)
        
        otherProductSegControl.layer.shadowColor = UIColor.black.cgColor
        otherProductSegControl.layer.shadowOpacity = 0.25
        otherProductSegControl.layer.masksToBounds = false
        otherProductSegControl.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        otherProductCollectionView.delegate = self
        otherProductCollectionView.dataSource = self
    }
    
}

extension OtherProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if otherProductSegControl.index == 0 {
            return self.nonsellProductList.count
        } else if otherProductSegControl.index == 1 {
            return self.sellProductList.count
        } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: MainCollectionViewCell = self.otherProductCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        if otherProductSegControl.index == 0 {
            let logo = "\(self.appDelegate.serverURL)imgload/\(nonsellProductList[indexPath.row].productImg![0])"
            let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
            cell.productImg.kf.setImage(with: resource)
            cell.productName.text = nonsellProductList[indexPath.row].productName
            cell.productPrice.text = "\(nonsellProductList[indexPath.row].productPrice!)원"
            
            return cell
        }else {
            let logo = "\(self.appDelegate.serverURL)imgload/\(sellProductList[indexPath.row].productImg![0])"
            let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
            cell.productImg.kf.setImage(with: resource)
            cell.productName.text = sellProductList[indexPath.row].productName
            cell.productPrice.text = "\(sellProductList[indexPath.row].productPrice!)원"
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else { return }

        if otherProductSegControl.index == 0 {
        detailVC.productId = nonsellProductList[indexPath.row].productId
        } else{
        detailVC.productId = sellProductList[indexPath.row].productId
        }

        let time = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: time) {
            //                    detailVC.detailList = self.detailProductList
            self.navigationController?.show(detailVC, sender: nil)
            
        }
    }
}

extension OtherProductViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "sellerIdSearchSuccess" {
            print(resultdata)
            var temp: [AllProduct] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let productId = item["productId"] as? String ?? ""
                    let productName = item["productName"] as? String ?? ""
                    let category = item["category"] as? String ?? ""
                    let updateDate = item["updateDate"] as? String ?? ""
                    let productPrice = item["productPrice"] as? Int ?? 0
                    let productSelled = item["productSelled"] as? Bool ?? false
                    let productImg = item["productImg"] as? [String] ?? [""]
                    let obj = AllProduct.init(productImg: productImg, productId: productId, productName: productName, productPrice: productPrice, productSelled: productSelled, category: category, updateDate: updateDate)
                    temp.append(obj)
                    
                }
            }
            for i in 0..<temp.count{
                if temp[i].productSelled == true {
                    sellProductList.append(temp[i])
                }else {
                    nonsellProductList.append(temp[i])
                }
            }
            
        }
    }
    
    
    func networkFail(code: String) {
        if(code == "sellerIdSearchError") {
            print("실패하였습니다.")
        }
    }
}
