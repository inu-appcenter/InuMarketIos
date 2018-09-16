//
//  CategoryProductViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 15..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryProductViewController: UIViewController {
    
    //MARK: properties
    let cellIdentifier: String = "MainCollectionViewCell"
    let headerIndentifier: String = "MainHeaderCollectionViewCell"
    
    var categoryTitle: String = ""
    var categoryDetail: String = ""
    var categorySub: String = ""
    var postCategory: String = ""
    let detailIdentifier: String = "detailView"

    
    
    var categoryProduct: [AllProduct] = []{
        didSet {
            if self.productCollectionView != nil {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    var model : NetworkModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //MARK: IBOutlet
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if categorySub == "전체"{
            postCategory = categoryTitle
        }else{
            postCategory = "\(categoryTitle)\(categorySub)"
        }
        model = NetworkModel(self)
        model?.categoryProduct(category: postCategory)
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        navigationItem.title = "\(categoryTitle) - \(categoryDetail)"
        
    }
}
 
extension CategoryProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProduct.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 68)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 140)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let cell: MainHeaderCollectionViewCell = productCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIndentifier, for: indexPath) as? MainHeaderCollectionViewCell else { return UICollectionViewCell() }
//        cell.headerTitle.isHidden = true
//        cell.createCategorySortButton()
//        productCollectionView.addSubview(cell.sortButton)
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        let logo = "\(self.appDelegate.serverURL)imgload/\(categoryProduct[indexPath.row].productImg![0])"
        let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
        cell.productImg.kf.setImage(with: resource)
        cell.productName.text = categoryProduct[indexPath.row].productName
        cell.productPrice.text = "\(String(categoryProduct[indexPath.row].productPrice!))원"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: detailIdentifier) as? DetailViewController else { return }
        detailVC.productId = categoryProduct[indexPath.row].productId
        
        self.navigationController?.show(detailVC, sender: nil)
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
//                    categoryProduct?.append(obj)
                }
            }
            categoryProduct = temp
        }
    }
    
    func networkFail(code: String) {
        if code == "categoryProductError"{
            print("error")
        }
    }
    
    
}

