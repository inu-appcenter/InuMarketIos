//
//  UploadSubCategoryViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 11..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class UploadSubCategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var mainCategoryLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var mainCategory : String?
    
    let bookCategory = ["2호관","3호관","4호관","5호관","6호관","7호관","8호관","9호관","12호관","15호관","16호관","19호관","22호관","27호관","28호관","29호관","기타"]
    let clothCategory = ["여성 의류", "남성 의류", "가방류", "기타"]
    let electircCategory = ["컴퓨터", "스마트폰","태블릿","TV/모니터","책상","의자","매트리스","기타"]
    let etcCategory = ["생활/사무","기타"]
    let roomCateogry = ["원룸", "투룸","복층","기타"]
    let foodCategory = ["1번 배식구","2번 배식구","3번 배식구","4번 배식구","5번 배식구","기타"]
    
    let postElectricCategory = ["컴퓨터", "스마트폰","태블릿","TV모니터","책상","의자","매트리스","기타"]
    let postEtcCategory  = ["생활사무","기타"]
    let postFoodCategory = ["1번배식구","2번배식구","3번배식구","4번배식구","5번배식구","기타"]
    let postClothCategory = ["여성의류", "남성의류", "가방류", "기타"]


    
    
    //    UploadSubCategoryCell
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCategoryLabel.text = mainCategory
        // Do any additional setup after loading the view.
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let category = ["책","의류","가전 / 가구", "잡화","원룸","식권"]

        switch mainCategory {
        case "책":
            return bookCategory.count
        case "의류":
            return clothCategory.count
        case "가전가구":
            return electircCategory.count
        case "잡화":
            return etcCategory.count
        case "원룸":
            return roomCateogry.count
        case "식권":
            return foodCategory.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadSubCategoryCell", for: indexPath)as! UploadSubCategoryCollectionViewCell
//        cell.subCategoryLabel.text = mainCategory
        switch mainCategory {
        case "책":
            cell.subCategoryLabel.text = bookCategory[indexPath.row]
        case "의류":
            cell.subCategoryLabel.text = clothCategory[indexPath.row]
        case "가전가구":
            cell.subCategoryLabel.text = electircCategory[indexPath.row]
        case "잡화":
            cell.subCategoryLabel.text = etcCategory[indexPath.row]
        case "원룸":
            cell.subCategoryLabel.text = roomCateogry[indexPath.row]
        case "식권":
            cell.subCategoryLabel.text = foodCategory[indexPath.row]
        default:
            cell.subCategoryLabel.text = "error"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadInfo")as? UploadInfoViewController{
            switch mainCategory {
            case "책":
                vc.category = "\(mainCategory!)\(bookCategory[indexPath.row])"
            case "의류":
                vc.category = "\(mainCategory!)\(postClothCategory[indexPath.row])"
            case "가전가구":
                vc.category = "\(mainCategory!)\(postElectricCategory[indexPath.row])"
            case "잡화":
                vc.category = "\(mainCategory!)\(postEtcCategory[indexPath.row])"
            case "원룸":
                vc.category = "\(mainCategory!)\(roomCateogry[indexPath.row])"
            case "식권":
                vc.category = "\(mainCategory!)\(postFoodCategory[indexPath.row])"
            default:
                vc.category = mainCategory
            }
            self.navigationController?.show(vc, sender: nil)
        }

    }
    

}
