//
//  MainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow
import SnapKit

class MainViewController: UIViewController {
    
    let bannerCellIdentifier: String = "BannerCollectionViewCell"
    let letterCellIdentifier: String = "LetterCollectionViewCell"
    let headerCellIdentifier: String = "MainHeaderCollectionViewCell"
    let mainCellIdentifier: String = "MainCollectionViewCell"

    @IBOutlet weak var productCollectionView: UICollectionView!

    
    //    @IBAction func button(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
//        if let vc = storyBoard.instantiateViewController(withIdentifier: "MyProductTable") as? MyProductTableViewController {
//
//            self.navigationController?.show(vc, sender: nil)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializing()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    @IBAction func leftButtonDidPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func rightButtonDidPressed(_ sender: Any) {

        
    }

    func initializing() {
        // navigation initializing
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        let mainlogo = UIImage(named: "mainLogo.png")
        let imageview = UIImageView(image: mainlogo)
        self.navigationItem.titleView = imageview
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 20
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell: MainHeaderCollectionViewCell = self.productCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerCellIdentifier, for: indexPath) as? MainHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        //정렬 버튼 추가
        productCollectionView.addSubview(cell.sortButton)
        cell.headerTitle?.text = "실시간 상품"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        switch section {
        case 2: return CGSize(width: screenWidth, height: 80)
        default: return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        switch indexPath.section {
        case 0: return CGSize(width: screenWidth, height: 80)
        case 1: return CGSize(width: screenWidth, height: 52)
        case 2: return CGSize(width: 100, height: 140)
        default: return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell: BannerCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: bannerCellIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bannerView.setImageInputs([ImageSource(image: UIImage(named: "promotionsAppcenter")!),
                                            ImageSource(image: UIImage(named: "promotionsAppcenter")!)])
            return cell
        case 1:
            guard let cell: LetterCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: letterCellIdentifier, for: indexPath) as? LetterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.letterImg.image = UIImage(named: "letterRead")
            cell.letterBoxLabel.text = "나의 쪽지함"
            cell.letterNum.text = "0"
            cell.rightImg.image = UIImage(named: "rightside")
            return cell
        case 2:
            guard let cell: MainCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: self.mainCellIdentifier, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.productImg.image = UIImage(named: "rectangle4Copy")
            cell.productName.text = "상품 이름"
            cell.productPrice.text = "250,000원"
            return cell
            
        default: return UICollectionViewCell()
            
        }
        
    }

}


