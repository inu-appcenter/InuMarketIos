//
//  CategoryProductViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 15..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class CategoryProductViewController: UIViewController {
    
    //MARK: properties
    let cellIdentifier: String = "MainCollectionViewCell"
    let headerIndentifier: String = "MainHeaderCollectionViewCell"
    
    var categoryTitle: String?
    var categoryDetail: String?
    
    //MARK: IBOutlet
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        navigationItem.title = "\(categoryTitle ?? "") - \(categoryDetail ?? "")"
    }
}

extension CategoryProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell: MainHeaderCollectionViewCell = productCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIndentifier, for: indexPath) as? MainHeaderCollectionViewCell else { return UICollectionViewCell() }
        cell.headerTitle.isHidden = true
        cell.createCategorySortButton()
        productCollectionView.addSubview(cell.sortButton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.productImg.image = UIImage(named: "rectangle4Copy")
        cell.productName.text = "상품 이름"
        cell.productPrice.text = "250,000원"
        return cell
    }
    
    
}

extension CategoryProductViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "categoryProductSuccess" {
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
//            productList = temp
//            // 판매 안된 순서로 나열
//            productList.sort { !$0.productSelled! && $1.productSelled! }
            
        }
    }
    
    func networkFail(code: String) {
        if code == "categoryProductError"{
            print("error")
        }
    }
    
    
}

