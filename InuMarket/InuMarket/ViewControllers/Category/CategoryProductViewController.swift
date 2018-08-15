//
//  CategoryProductViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 15..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class CategoryProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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

