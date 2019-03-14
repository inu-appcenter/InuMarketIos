//
//  MainProductCollectionViewCell.swift
//  InuMarket
//
//  Created by 김성은 on 04/03/2019.
//  Copyright © 2019 동균. All rights reserved.
//

import UIKit

class MainProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: properties
    let productCellIdentifier: String = "ProductCollectionViewCell"
    
    var bookProductList: [AllProduct] = []{
        didSet {
            if self.mainProductCollectionView != nil {
                self.mainProductCollectionView.reloadData()
                
            }
        }
    }
    var ticketProductList: [AllProduct] = []{
        didSet {
            if self.mainProductCollectionView != nil {
                self.mainProductCollectionView.reloadData()
                
            }
        }
    }
    var roomProductList: [AllProduct] = []{
        didSet {
            if self.mainProductCollectionView != nil {
                self.mainProductCollectionView.reloadData()
                
            }
        }
    }
    
    @IBOutlet var mainProductCollectionView: UICollectionView!
}



extension MainProductCollectionViewCell: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ProductCollectionViewCell = self.mainProductCollectionView.dequeueReusableCell(withReuseIdentifier: productCellIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.productName.text = bookProductList[indexPath.row].productName
        cell.productPrice.text = "\(String(bookProductList[indexPath.row].productPrice!))원"
        
        if bookProductList[indexPath.row].category == "책전공" {
            cell.productSubCategory.isHidden = false
            cell.productSubCategory.text = "전공"
        }
        else if bookProductList[indexPath.row].category == "책교양" {
            cell.productSubCategory.isHidden = false
            cell.productSubCategory.text = "교양"
        }
        else {
            cell.productSubCategory.isHidden = false
            cell.productSubCategory.text = "기타"
        }
        
        return cell
    }
    
    
}

extension MainProductCollectionViewCell: NetworkCallback {
    func networkSuc(resultdata: Any, code: String) {
        if code == "allProductSuccess" {
            //print(resultdata)
            
            //var temp: [AllProduct] = []
            
            var bookTemp: [AllProduct] = []
            var ticketTemp: [AllProduct] = []
            var roomTemp: [AllProduct] = []
            var count: Int = 0
            if let items = resultdata as? [[NSDictionary]] {
                for item in items {
                    if let item2 = item as? [NSDictionary] {
                        for item2 in item {
                            //print(item2)
                            let productId = item2["productId"] as? String ?? ""
                            let productName = item2["productName"] as? String ?? ""
                            let category = item2["category"] as? String ?? ""
                            let updateDate = item2["updateDate"] as? String ?? ""
                            let productPrice = item2["productPrice"] as? Int ?? 0
                            let productSelled = item2["productSelled"] as? Bool ?? false
                            let productImg = item2["productImg"] as? [String] ?? [""]
                            let obj = AllProduct.init(productImg: productImg, productId: productId, productName: productName, productPrice: productPrice, productSelled: productSelled, category: category, updateDate: updateDate)
                            //temp.append(obj)
                            if count == 0 { ticketTemp.append(obj) }
                            else if count == 1 { bookTemp.append(obj) }
                            else if count == 2 { roomTemp.append(obj) }
                        }
                    }
                    count = count + 1
                    /*let productId = item["productId"] as? String ?? ""
                     let productName = item["productName"] as? String ?? ""
                     let category = item["category"] as? String ?? ""
                     let updateDate = item["updateDate"] as? String ?? ""
                     let productPrice = item["productPrice"] as? Int ?? 0
                     let productSelled = item["productSelled"] as? Bool ?? false
                     let productImg = item["productImg"] as? [String] ?? [""]
                     let obj = AllProduct.init(productImg: productImg, productId: productId, productName: productName, productPrice: productPrice, productSelled: productSelled, category: category, updateDate: updateDate)
                     temp.append(obj)*/
                    
                }
            }
            
            bookProductList = bookTemp
            bookProductList.sort { !$0.productSelled! && $1.productSelled! }
            ticketProductList = ticketTemp
            ticketProductList.sort { !$0.productSelled! && $1.productSelled! }
            roomProductList = roomTemp
            roomProductList.sort { !$0.productSelled! && $1.productSelled! }
            
            //productList = temp
            // 판매 안된 순서로 나열
            //productList.sort { !$0.productSelled! && $1.productSelled! }
            
            
            //            // 낮은 가격순
            //            productList.sort { $0.productPrice! < $1.productPrice!}
            //            // 높은 가격순
            //            productList.sort { $1.productPrice! < $0.productPrice!}
        }
    }
    
    func networkFail(code: String) {
        print("실패하였습니다.")
    }
    
    
}
