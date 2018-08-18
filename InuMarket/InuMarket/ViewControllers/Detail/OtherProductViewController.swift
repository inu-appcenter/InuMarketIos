//
//  OtherProductViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 18..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class OtherProductViewController: UIViewController {
    
    //MARK: properties
    var productName: String?
    let cellIdentifier: String = "MainCollectionViewCell"
    
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
            return 20
        } else if otherProductSegControl.index == 1 {
            return 10
        } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = otherProductCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.productImg.image = UIImage(named: "rectangle4Copy")
        cell.productName.text = "상품 이름"
        cell.productPrice.text = "250,000원"
        return cell
    }
    
    
}
