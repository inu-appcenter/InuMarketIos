//
//  BannerCollectionViewCell.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bannerView: ImageSlideshow!
    
//    override func awakeFromNib() {
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BannerCollectionViewCell.didTap))
//        bannerView.addGestureRecognizer(gestureRecognizer)
//    }
//    
//    @objc func didTap() {
//        print("banner selected")
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = storyBoard.instantiateViewController(withIdentifier: "MainView") as? MainViewController else {
//            return
//        }
//        bannerView.presentFullScreenController(from: vc)
//    }
}
